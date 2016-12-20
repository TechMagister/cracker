require "socket"

require "./db"
require "./messages/messages"

module Cracker
  class Server
    @db : Db
    @hostname : String
    @port : Int32
    @exit = false

    def initialize(@db : Db, @hostname : String, @port : Int32)
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
      server = TCPServer.new(@hostname, @port)
      puts "Listening on port #{@port}"
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
