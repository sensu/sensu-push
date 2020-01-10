module Sensu
  module Run
    class Event
      attr_reader :entity, :check

      def initialize(entity, check)
        @entity = entity
        @check = check
      end

      def to_hash
        {
          :entity => @entity.to_hash,
          :check => @check.to_hash
        }
      end
    end
  end
end
