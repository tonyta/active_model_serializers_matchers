module ActiveModelSerializersMatchers
  class AssociationMatcher
    attr_reader :actual, :root, :type, :checks

    def initialize(root, type)
      @root = root
      @type = type
      @checks = [AssociationCheck.new(self, type)]
    end

    def matches?(actual)
      @actual = actual.is_a?(Class) ? actual : actual.class
      checks.all?(&:pass?)
    end

    def does_not_match?(actual)
      raise NegatedUseNotSupportedError
    end

    def description
      checks.map(&:description).join(' ')
    end

    def failure_message
      checks.find(&:fail?).failure_message
    end

    def root_association
      associations[root]
    end

    def as(key)
      checks << KeyCheck.new(self, key)
      self
    end

    def serialized_with(serializer)
      checks << SerializerCheck.new(self, serializer)
      self
    end

    def with_embed_key(embed_key)
      checks << EmbedKeyCheck.new(self, embed_key)
      self
    end

    private

    def associations
      actual._associations
    end
  end
end
