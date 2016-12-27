require "cli"

require "../client"
require "../message_builder"

module Cracker::Commands
  class Cracker < Cli::Supercommand
    class Client < Cli::Command

      class Help
        header "Auto completion client for Cracker server"
        footer "(C) 2016 Ghilde Sud"
      end

      class Options
        string "-p", desc: "Server port", default: "1234"
        string "--starts-with", desc: "format : Class#method for instance method\n" +
                                "         Class.method for class method"
        bool "--context", desc: "Take a context in stdin"
        string "--add-path", desc: "Source path to add to completion database"
        bool "--stop-server", desc: "Stop the server"
        help
      end

      def port?
        options.p.to_u32?
      end

      def port
        options.p.to_i
      end

      def validate
        error! "Invalid port" unless port?
        if !(options.starts_with? || options.add_path? || options.stop_server? || options.context?)
          error! "You should specify at least one option"
        end
      end

      def run
        validate
        begin
          client = ::Cracker::Client.new port
          cmd = if options.starts_with?
                  MessageBuilder.match options.starts_with
                elsif options.add_path?
                  MessageBuilder.add_path options.add_path
                elsif options.stop_server?
                  MessageBuilder.stop_server
                elsif options.context?
                  ctx = STDIN.gets '\0' || " "
                  ctx = ctx.not_nil![0...-1]
                  MessageBuilder.context ctx
                else
                  nil
                end
          client.send cmd if cmd
        rescue err
          STDERR.puts "Fail to send completion request to the server on port : #{options.p}"
          STDERR.puts err.to_s
        end
      end
    end
  end
end
