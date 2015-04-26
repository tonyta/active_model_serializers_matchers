module ActiveModelSerializersMatchers
  class AssociationMatcher
    class EmbedKeyCheck
      attr_reader :matcher, :embed_key

      def initialize(matcher, embed_key)
        @matcher = matcher
        @embed_key = embed_key
      end

      def pass?
        actual_embed_key.to_s == embed_key.to_s
      end

      def fail?
        !pass?
      end

      def description
        "with embed key #{ embed_key.inspect }"
      end

      def failure_message
        "expected #{ matcher.actual } '#{ matcher.type } #{ matcher.root.inspect }' association to explicitly have embed key #{ embed_key.inspect } but instead #{ actual_embed_key_string }"
      end

      private

      def actual_embed_key
        matcher.root_association[:association_options][:embed_key]
      end

      def actual_embed_key_string
        if actual_embed_key
          "was #{ actual_embed_key.inspect }"
        else
          'has none'
        end
      end
    end
  end
end
