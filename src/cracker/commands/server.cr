require "cli"

module Cracker::Commands
  class Cracker < Cli::Supercommand
    class Server < Cli::Command
      class Help
        header "Auto completion server for the crystal language"
        footer "(C) 2016 Ghilde Sud"
      end

      class Options
        string "-p", default: "1234", desc: "Server port"
        arg "crystal_source", desc: "Path to the crystal source", required: true
        help
      end

      def port?
        options.p.to_u32?
      end

      def port
        options.p.to_i
      end

      def validate
        error! "Invalid port given : #{port?}" unless port?
      end

      def run
        validate
        generator = ::Cracker::Generator.new [args.crystal_source]
        db = generator.db
        server = ::Cracker::Server.new db, "localhost", port
        server.run
      end
    end
  end
end
