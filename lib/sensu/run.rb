require "optparse"
require "sensu/run/version"
require "sensu/run/check"

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
        opts.on("-c", "--check-name NAME", "Sensu check name") do |name|
          options[:check_name] = name
        end
        opts.on("-e", "--entity-name NAME", "Sensu entity name") do |name|
          options[:entity_name] = name
        end
        opts.on("-t", "--check-timeout SECONDS", "Sensu check execution timeout") do |timeout|
          options[:timeout] = timeout.to_i
        end
        opts.on("-T", "--check-ttl SECONDS", "Sensu check TTL") do |ttl|
          options[:ttl] = ttl.to_i
        end
        opts.on("-H", "--handlers NAME[,NAME]", "Sensu event handlers") do |handlers|
          options[:handlers] = handlers.split(",")
        end
        opts.on("-b", "--backends URL[,URL]", "URL or comma-delimited list of Sensu Go Backend API URLss") do |backends|
          options[:backends] = backends.split(",")
        end
        opts.on("-k", "--api-key KEY", "Sensu Go Backend API key") do |key|
          options[:api_key] = key
        end
      end

      optparse.parse!(arguments)
      options[:command] = arguments.join(" ")

      options
    end
  end
end
