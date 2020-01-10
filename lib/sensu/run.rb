require "optparse"
require "sensu/run/version"
require "sensu/run/entity"
require "sensu/run/check"
require "sensu/run/event"
require "sensu/run/api_client"

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
        opts.on("-n", "--namespace NAME", "Sensu Go namespace") do |name|
          options[:namespace] = name
        end
        opts.on("-c", "--check-name NAME", "Sensu Go check name") do |name|
          options[:check_name] = name
        end
        opts.on("-e", "--entity-name NAME", "Sensu Go entity name") do |name|
          options[:entity_name] = name
        end
        opts.on("-t", "--check-timeout SECONDS", "Sensu Go check execution timeout") do |timeout|
          options[:timeout] = timeout.to_i
        end
        opts.on("-T", "--check-ttl SECONDS", "Sensu Go check TTL") do |ttl|
          options[:ttl] = ttl.to_i
        end
        opts.on("-H", "--handlers NAME[,NAME]", "Sensu Go event handlers") do |handlers|
          options[:handlers] = handlers.split(",")
        end
        opts.on("-b", "--backends URL[,URL]", "URL or comma-delimited list of Sensu Go Backend API URLs") do |backends|
          options[:backends] = backends.split(",")
        end
        opts.on("-k", "--api-key KEY", "Sensu Go Backend API key") do |key|
          options[:api_key] = key
        end
        opts.on("-s", "--insecure-skip-tls-verify", "Skip TLS verify peer when using HTTPS") do |key|
          options[:skip_tls_verify_peer] = true
        end
      end

      optparse.parse!(arguments)
      options[:command] = arguments.join(" ")

      options
    end
  end
end
