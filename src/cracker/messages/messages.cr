require "json"
require "../db"

module Cracker::Messages
  enum CommandType
    Match =  0
    AddPath
    Exit  = 99
  end

  class Command
    JSON.mapping({
      type:    CommandType,
      content: String,
    })

    def initialize(@type, @content)
    end

    def self.match_command(content : String)
      new CommandType::Match, content
    end

    def self.add_path_command(path : String)
      new CommandType::AddPath, path
    end

    def self.exit_command
      new CommandType::Exit, ""
    end

  end

  struct Result
    JSON.mapping({
      name:      String,
      file:      String,
      location:  String?,
      type:      Cracker::EntryType,
      signature: String,
    })

    def initialize(dbentry : DbEntry)
      @name = dbentry.name
      @file = dbentry.file
      @location = dbentry.location
      @type = dbentry.type
      @signature = dbentry.signature
    end
  end
end
