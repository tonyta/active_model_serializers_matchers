module ActiveModelSerializersMatchers
  class AssociationMatcher
    class SerializerCheck
      attr_reader :matcher, :serializer

      def initialize(matcher, serializer)
        @matcher = matcher
        @serializer = serializer
      end

      def pass?
        actual_serializer.to_s == serializer.to_s
      end

      def fail?
        !pass?
      end

      def description
        "serialized with #{ serializer }"
      end

      def failure_message
        "expected #{ matcher.actual } '#{ matcher.type } #{ matcher.root.inspect }' association to explicitly have serializer #{ serializer } but instead #{ actual_serializer_string }"
      end

      private

      def actual_serializer
        matcher.root_association[:options][:serializer]
      end

      def actual_serializer_string
        if actual_serializer
          "was #{ actual_serializer }"
        else
          "has none"
        end
      end
    end
  end
end
