require "compiler/crystal/syntax"

module Cracker
  class Context

    getter before

    @before : String

    def initialize(@buffer : String, @line : Int32, @column : Int32)
      context = Array(String).new

      (@buffer.size-1).downto 0 do |i|
        break if @buffer[i].match /[^\w]/
        context.unshift @buffer[i]
      end

      @before = context

    end

    def parse
      Crystal::Parser.parse @buffer
    end

  end
end
