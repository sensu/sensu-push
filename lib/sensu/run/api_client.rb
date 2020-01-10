require "net/http"

module Sensu
  module Run
    class APIClient
      def initialize(options={})
        @options = options
      end
    end
  end
end
