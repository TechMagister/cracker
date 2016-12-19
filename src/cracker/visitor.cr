require "compiler/crystal/syntax"

module Cracker
  class Visitor < Crystal::Visitor
    def visit(any)
      false
    end
  end
end
