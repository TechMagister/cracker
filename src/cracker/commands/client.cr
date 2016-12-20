require "cli"

require "../client"
require "../messages/messages"

module Cracker::Commands
  class MainCommand < Cli::Supercommand
    class Client < Cli::Command

      class Help
        header "Auto completion client for Cracker server"
        footer "(C) 2016 Ghilde Sud"
      end

      class Options
        string "-p", desc: "Server port", default: "1234"
        string "--starts-with", desc: "Like the name says", required: true
        help
      end

      def port?
        options.p.to_u32?
      end

      def port
        options.p.to_i
      end

      def run
        error! "Invalid port" unless port?
        begin
          client = Cracker::Client.new port
          cmd = Cracker::Messages::Command.match_command options.starts_with
          client.send cmd
        rescue err
          STDERR.puts "Fail to send completion request to the server on port : #{options.p}"
          STDERR.puts err.to_s
        end
      end
    end
  end
end
