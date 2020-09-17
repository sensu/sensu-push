module Sensu
  module Push
    class Entity
      attr_reader :name, :namespace

      def initialize(options={})
        @options = options
        @name = options[:entity_name]
        @namespace = options.fetch(:namespace, "default")
      end

      def to_hash
        {
          :metadata => {
            :name => @name,
            :namespace => @namespace
          },
          :entity_class => "proxy"
        }
      end
    end
  end
end
