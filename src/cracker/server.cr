require "socket"

require "./db"
require "./server/messages"

module Cracker
  class Server
    @db : Db
    @exit = false

    def initialize(@db : Db)
    end

    def process(message : String)
      cmd = Messages::Command.from_json(message)

      case cmd.type
      when Messages::CommandType::Match
        @db.starts_with?(cmd.content).to_json
      when Messages::CommandType::Exit
        @exit = true
        "Exit".to_json
      end
    end

    def run
      server = TCPServer.new("localhost", 1234)
      puts "Listening on port 1234"
      loop do
        server.accept do |client|
          message = client.gets
          client << process(message) if message
          break if @exit
        end
      end
    end
  end
end
