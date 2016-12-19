require "./cracker/*"

require "compiler/crystal/syntax"

file = ARGV[0]

raise "File does not exists" if !File.exists?(file)

node = Crystal::Parser.parse File.read(file)

db = Cracker::Db.new
visitor = Cracker::DbVisitor.new db
transformer = Cracker::Transformer.new visitor

node.transform transformer

puts db.starts_with "Cracker::Db#push"
