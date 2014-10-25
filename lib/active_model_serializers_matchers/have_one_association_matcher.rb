module ActiveModelSerializersMatchers
  class HaveOneAssociationMatcher
    attr_accessor :actual, :root, :key, :serializer, :key_check, :serializer_check

    def initialize(root)
      @root             = root
      @key_check        = false
      @serializer_check = false
    end

    def matches?(actual)
      @actual = actual.is_a?(Class) ? actual : actual.class
      match_association? && match_key? && match_serializer?
    end

    def as(key)
      self.key_check = true
      self.key = key
      self
    end

    def serialized_with(serializer)
      self.serializer_check = true
      self.serializer = serializer
      self
    end

    def description
      msg = "have one #{root}"
      msg << " as \"#{key}\"" if key_check
      msg << " serialized with #{serializer}" if serializer_check
      msg
    end

    def failure_message
      if match_association?
        "expected #{actual} association options for #{root}: #{root_association.options} to include: #{expected_association}"
      else
        "expected #{actual} associations: #{associations} to include: {#{root.inspect}=>(subclass of ActiveModel::Serializer::Associations::HasOne)}"
      end
    end

    def failure_message_when_negated
      if match_association?
        "expected #{actual} associations: #{associations} to not include: {#{root.inspect}=>(subclass of ActiveModel::Serializer::Associations::HasOne)}"
      else
        "expected #{actual} association options for #{root}: #{root_association.options} to not include: #{expected_options}"
      end
    end

    def expected_options
      expected = { root: root }
      expected[:key] = key if key_check
      expected[:serializer] = serializer if serializer_check
      expected
    end

    private

    def associations
      actual._associations
    end

    def root_association
      associations[root]
    end

    def match_association?
      return false if root_association.nil?
      root_association.superclass == ActiveModel::Serializer::Associations::HasOne
    end

    def match_key?
      return true unless key_check
      root_association.options[:key] == key
    end

    def match_serializer?
      return true unless serializer_check
      root_association.options[:serializer].to_s == serializer.to_s
    end
  end
end
