require "./messages/*"

module Cracker

  class MessageBuilder

    def self.match(content : String)
      Messages::Command.match_command content
    end

    def self.add_path(path : String)
      Messages::Command.add_path_command path
    end

    def self.stop_server
      Messages::Command.exit_command
    end

  end

end
