require "open3"

module Sensu
  module Push
    class Check
      attr_reader :name, :namespace, :output, :status

      def initialize(options={})
        @options = options
        @name = @options[:check_name]
        @namespace = @options.fetch(:namespace, "default")
      end

      def exec!
        stdin, stdout, stderr, wait = Open3.popen3(@options[:command])
        @output = "#{stdout.read}\n#{stderr.read}"
        @status = wait.value.exitstatus
        [@output, @status]
      end

      def to_hash
        {
          :metadata => {
            :name => @name,
            :namespace => @namespace
          },
          :command => @options[:command],
          :output => @output,
          :status => @status,
          :ttl => @options.fetch(:ttl, 0)
        }
      end
    end
  end
end
