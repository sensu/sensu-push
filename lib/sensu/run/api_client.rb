require "uri"
require "json"

begin
  require "net/https"
rescue LoadError
  require "net/http"
end

module Sensu
  module Run
    class APIClient
      def initialize(options={})
        @options = options
        uri = URI.parse(select_backend)
        @http = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https"
          @http.use_ssl = true
          @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          if options[:skip_tls_verify_peer]
            @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          end
        end
      end

      def select_backend
        @backends ||= []
        if @backends.empty?
          @backends = @options[:backends].shuffle
        end
        @backends.shift
      end

      def entity_exists?(entity)
        request = Net::HTTP::Get.new("/api/core/v2/namespaces/#{entity.namespace}/entities/#{entity.name}")
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Key #{@options[:api_key]}"
        response = @http.request(request)
        response.code == "200"
      end

      def create_entity(entity)
        request = Net::HTTP::Post.new("/api/core/v2/namespaces/#{entity.namespace}/entities")
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Key #{@options[:api_key]}"
        request.body = JSON.dump(entity.to_hash)
        response = @http.request(request)
        puts response.inspect
      end

      def create_entity_if_missing(entity)
        unless entity_exists?(entity)
          create_entity(entity)
        end
      end

      def create_event(event)
        request = Net::HTTP::Post.new("/api/core/v2/namespaces/#{event.entity.namespace}/events")
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Key #{@options[:api_key]}"
        request.body = JSON.dump(event.to_hash)
        response = @http.request(request)
        puts response.inspect
      end
    end
  end
end
