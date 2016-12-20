require "socket"

require "./server/messages"

module Cracker
  class Client
    def initialize(@port : Int32)
      @client = TCPSocket.new("localhost", @port)
    end

    def send(cmd : Messages::Command)
      @client << cmd.to_json << "\n"
      response = @client.gets
      @client.close
      puts response
    end
  end
end
