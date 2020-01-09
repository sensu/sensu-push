require "optparse"
require "sensu/run/version"

module Sensu
  module Run
    def self.read_cli_opts(arguments=ARGV)
      options = {}

      optparse = OptionParser.new do |opts|
        opts.on("-h", "--help", "Display this message") do
          puts opts
          exit
        end
        opts.on("-V", "--version", "Display version") do
          puts VERSION
          exit
        end
      end

      optparse.parse!(arguments)
      options
    end
  end
end
