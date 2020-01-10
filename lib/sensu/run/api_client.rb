require "net/http"
require "uri"
require "json"

module Sensu
  module Run
    class APIClient
      def initialize(options={})
        @options = options
        uri = URI.parse(select_backend)
        @http = Net::HTTP.new(uri.host, uri.port)
      end

      def select_backend
        @backends ||= []
        if @backends.empty?
          @backends = @options[:backends].shuffle
        end
        @backends.shift
      end

      def post_event(event)
        namespace = @options.fetch(:namespace, "default")
        request = Net::HTTP::Post.new("/api/core/v2/namespaces/#{namespace}/events")
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Key #{@options[:api_key]}"
        request.body = JSON.dump(event)
        response = @http.request(request)
        puts response.inspect
      end
    end
  end
end
