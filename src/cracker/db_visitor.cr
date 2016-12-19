require "./visitor"
require "./db"

module Cracker

  class DbVisitor < Visitor

    @class_pop_module = 0

    def initialize(@db : Db)
    end

    def visit(node : Crystal::ModuleDef)
      @db.push_module node.name.to_s
      true
    end

    def visit(node : Crystal::ClassDef)
      s = node.name.to_s.split "::"
      @class_pop_module = s.size-1
      0.upto(s.size-2) do |i|
        @db.push_module s[i]
      end
      @db.push_class s.last
      true
    end

    def visit(node : Crystal::Def)
      @db.push_def node if node.visibility == Crystal::Visibility::Public
      false
    end

    def visit(node : Crystal::Expressions)
      true
    end

    def end_visit(node : Crystal::ModuleDef)
      @db.pop_module
    end

    def end_visit(node : Crystal::ClassDef)
      @class_pop_module.times do |i|
        @db.pop_module
      end
      @db.pop_class
    end

    def visit(node)
      false
    end


  end

end
