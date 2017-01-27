require "cli"

module Cracker::Commands
  class Main < Cli::Supercommand

    class Help
      header "Auto completion client / server for crystal"
      footer "(C) 2017 Tech Magister"
    end

  end
end
