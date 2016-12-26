require "json"

module Cracker
  enum EntryType
    Module
    Class
    Function

    def to_json(io)
      io << '"' << to_s << '"'
    end
  end

  struct DbEntry
    JSON.mapping(
      name: String,
      file: String,
      location: String?,
      type: EntryType,
      signature: String
    )

    def initialize(@name : String, node : Crystal::Def, @file : String, @type = EntryType::Function)
      @signature = node.to_s.partition("\n")[0]
      @location = node.location.to_s if node.location
    end

    def_equals_and_hash @signature
  end

  TYPE_REGEXP = /(?<type>[A-Z][\w]+)(?:\(.+\))?\.new/

  class Db
    @raw_storage = Array(DbEntry).new

    @path_stack = Array(String).new

    def debug
      @raw_storage.each do |func|
        puts func
      end
    end

    def with_context(ctx : String) : Array(DbEntry)
      content = ""
      (ctx.size-1).downto 0 do |i|
        char = ctx[i]
        break unless char.to_s.match /[@A-Za-z_\.]/
        content += char
      end
      content = content.reverse
      split = content.split '.'

      varname = split[0]?
      func = split[1]? || ""

      res = Array(DbEntry).new

      if varname
        if varname.match(/^[A-Z]/)
          pattern = varname + '.' + func
          res = starts_with? pattern
        elsif match = ctx.match /#{varname} = #{TYPE_REGEXP}/
          pattern = match["type"] + '#' + func
          res = starts_with? pattern
        elsif match = ctx.match /#{varname} : (?<type>[A-Za-z]+)/
          pattern = match["type"] + "#" + func
          res = starts_with? pattern
        end
      end

      res
    end

    def starts_with?(pattern : String) : Array(DbEntry)
      res = Array(DbEntry).new
      lookfor_class = pattern.ends_with? "::"
      @raw_storage.each do |entry|
        if entry.name.starts_with?(pattern)
          if !lookfor_class
            res << entry
          else
            res << entry
          end
        end
      end
      res.uniq
    end

    def push_module(name : String)
      @path_stack << name
    end

    def push_class(node : Crystal::ClassDef)
      @path_stack << node.name.to_s.split("::").last
    end

    def push_def(func : Crystal::Def, file : String)
      func_sep = (func.receiver ? "." : "#")
      full = @path_stack.join("::") + "#{func_sep}#{func.name}(#{func.args.join(',')})"
      full += ": #{func.return_type}" if func.return_type

      @raw_storage << DbEntry.new full, func, file
    end

    def pop_module
      @path_stack.pop?
    end

    def pop_class
      @path_stack.pop?
    end
  end
end
