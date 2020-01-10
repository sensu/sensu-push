require "open3"

module Sensu
  module Run
    class Check
      attr_reader :output, :status

      def initialize(options={})
        @options = options
      end

      def exec
        stdin, stdout, stderr, wait = Open3.popen3(@options[:command])
        @output = "#{stdout.read}\n#{stderr.read}"
        @status = wait.value.exitstatus
        [@output, @status]
      end

      def event
        {
          :entity => {
            :metadata => {
              :name => @options[:entity_name],
              :namespace => @options.fetch(:namespace, "default")
            },
            :entity_class => "proxy"
          },
          :check => {
            :metadata => {
              :name => @options[:check_name],
              :namespace => @options.fetch(:namespace, "default")
            },
            :command => @options[:command],
            :output => @output,
            :status => @status
          }
        }
      end
    end
  end
end
