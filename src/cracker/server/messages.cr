require "json"
require "../db"

module Cracker::Messages
  enum CommandType
    Match =  0
    Exit  = 99
  end

  class Command
    JSON.mapping({
      type:    CommandType,
      content: String,
    })

    def initialize(@type, @content)
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
