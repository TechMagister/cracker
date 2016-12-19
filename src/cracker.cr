require "json"
require "./cracker/*"

path = ARGV[0]
exp = ARGV[1]

generator = Cracker::Generator.new [path]

db = generator.db

puts db.starts_with(exp).to_json
