module ActiveModelSerializersMatchers
  class AssociationMatcher
    class KeyCheck
      attr_reader :matcher, :key

      def initialize(matcher, key)
        @matcher = matcher
        @key = key
      end

      def pass?
        actual_key.to_s == key.to_s
      end

      def fail?
        !pass?
      end

      def description
        "as #{ key.inspect }"
      end

      def failure_message
        "expected #{ matcher.actual } '#{ matcher.type } #{ matcher.root.inspect }' association to explicitly have key #{ key.inspect } but instead #{ actual_key_string }"
      end

      private

      def actual_key
        matcher.root_association.options[:key]
      end

      def actual_key_string
        if actual_key
          "was #{ actual_key.inspect }"
        else
          'has none'
        end
      end
    end
  end
end
