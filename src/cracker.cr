require "json"
require "cli"

require "./cracker/*"

class Command < Cli::Supercommand
  class Client < Cli::Command
    class Help
      header "Auto completion client for Cracker server"
      footer "(C) 2016 Ghilde Sud"
    end

    class Options
      string "--starts-with", desc: "Like the name says", required: true
      help
    end

    def run
      client = Cracker::Client.new 1234
      cmd = Cracker::Messages::Command.new Cracker::Messages::CommandType::Match, options.starts_with
      client.send cmd
    end
  end

  class Server < Cli::Command
    class Help
      header "Auto completion server for the crystal language"
      footer "(C) 2016 Ghilde Sud"
    end

    class Options
      arg "crystal_source", desc: "Path to the crystal source", required: true
      help
    end

    def run
      generator = Cracker::Generator.new [args.crystal_source]
      db = generator.db
      server = Cracker::Server.new db
      server.run
    end
  end
end

Command.run ARGV
