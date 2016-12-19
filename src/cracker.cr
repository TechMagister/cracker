require "./cracker/*"

path = ARGV[0]

generator = Cracker::Generator.new [path]

db = generator.db

puts db.starts_with "Cracker::"
