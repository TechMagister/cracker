require "./db_visitor"

module Cracker

  class Transformer < Crystal::Transformer

    def initialize(@visitor : Cracker::DbVisitor)
    end

    def transform(node)
      @visitor.accept node
    end
  end

end
