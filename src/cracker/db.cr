module Cracker

  class Db

    @raw_storage = Array(String).new

    @path_stack = Array(String).new


    def initialize
    end

    def debug
      @raw_storage.each do |func|
        puts func
      end
    end

    def starts_with(pattern : String)
      res = Array(String).new
      @raw_storage.each do |entry|
        res << entry[pattern.size..-1] if entry.starts_with?(pattern)
      end
      res
    end

    def push_module(name : String)
      @path_stack << name
    end

    def push_class(name : String)
      @path_stack << name
    end

    def push_def(func : Crystal::Def)
      full = @path_stack.join("::") + "##{func.name}(#{func.args.join(',')})"
      full += ": #{func.return_type}" if func.return_type

      @raw_storage << full
    end

    def pop_module
      @path_stack.pop
    end

    def pop_class
      @path_stack.pop
    end

  end

end
