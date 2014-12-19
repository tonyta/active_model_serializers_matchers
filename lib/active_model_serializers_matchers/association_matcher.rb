module ActiveModelSerializersMatchers
  class AssociationMatcher

    attr_reader :root, :type, :association_check
    attr_reader :actual

    def initialize(root:, type:)
      @root = root
      @type = type
      @association_check = AssociationCheck.new(self)
    #   key_check         = KeyCheck.new(self)
    #   serializer_check  = SerializerCheck.new(self)
    end

    def matches?(actual)
      @actual = actual.is_a?(Class) ? actual : actual.class
      association_check.passes?
    end

    def description
      association_check.description
    end

    def failure_message
      association_check.failure_message
    end

    def root_association
      associations[root]
    end

    private

    def associations
      actual._associations
    end

    class AssociationCheck

      attr_reader :matcher

      def initialize(matcher)
        @matcher = matcher
      end

      def passes?
        return false if matcher.root_association.nil?
        matcher.root_association.superclass == association_type
      end

      def description
        "#{ association_string } #{ matcher.root.inspect }"
      end

      def failure_message
        "expected #{ matcher.actual } to define a '#{ matcher.type } #{ matcher.root.inspect }' association"
      end

      private

      def association_type
        case matcher.type
        when :has_one
          ActiveModel::Serializer::Associations::HasOne
        when :has_many
          ActiveModel::Serializer::Associations::HasMany
        else
          raise ArgumentError, "'#{type}' is an invalid association type."
        end
      end

      def association_string
        case matcher.type
        when :has_one
          'have one'
        when :has_many
          'have many'
        end
      end
    end
  end
end
