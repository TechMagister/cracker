require "json"
require "cli"
require "./cracker/*"

require "./cracker/commands/client"
require "./cracker/commands/server"

Cracker::Commands::MainCommand.run ARGV
