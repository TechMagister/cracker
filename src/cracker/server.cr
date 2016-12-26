require "socket"

require "./db"
require "./messages/messages"

module Cracker
  class Server
    @db : Db
    @hostname : String
    @port : Int32
    @exit = false

    macro success(results)
      {status: "success", results: {{results}}}.to_json
    end

    def initialize(@db : Db, @hostname : String, @port : Int32)
    end

    def process(message : String)
      cmd = Messages::Command.from_json(message)

      case cmd.type
      when Messages::CommandType::Match
        success(@db.starts_with?(cmd.content))
      when Messages::CommandType::AddPath
        if Dir.exists? cmd.content
          begin
            files = Generator.add_paths @db, [cmd.content]
            {status: "success", message: "#{files} files processed"}.to_json
          rescue e
            {status: "error", message: e.to_s}.to_json
          end
        else
          {status: "error", message: "#{cmd.content} folder does not exists."}.to_json
        end
      when Messages::CommandType::Exit
        @exit = true
        {status: "success", message: "Completion server stoped"}.to_json
      when Messages::CommandType::Context
        res = @db.with_context cmd.content
        success res
      end
    end

    def run
      server = TCPServer.new(@hostname, @port)
      puts "Listening on port #{@port}"
      loop do
        server.accept do |client|
          message = client.gets
          client << process(message) if message
        end
        break if @exit
      end
    end
  end
end
