require "compiler/crystal/syntax"

require "./db"
require "./db_visitor"

module Cracker
  class Generator
    getter db

    @db : Db
    @visitor : DbVisitor
    @transformer : Transformer

    def initialize(@paths : Array(String))
      @db = Db.new
      @visitor = DbVisitor.new @db
      @transformer = Transformer.new @visitor
      compute_paths
    end

    def compute_paths
      @paths.each do |path|
        Dir.glob "#{path}/**/*.cr" do |filename|
          parse filename
        end
      end
    end

    def parse(filename : String)
      node = Crystal::Parser.parse File.read(filename)
      @visitor.current_file = filename
      node.transform @transformer
    end
  end
end
