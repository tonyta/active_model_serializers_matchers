module ActiveModelSerializersMatchers
  class HaveManyAssociationMatcher
    attr_accessor :actual, :root, :key, :serializer, :key_check, :serializer_check

    def initialize(root)
      @root             = root
      @key_check        = false
      @serializer_check = false
    end

    def matches?(actual)
      @actual = actual.is_a?(Class) ? actual : actual.class
      association and match_root? && match_key? && match_serializer?
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
      msg = "have many #{root}"
      msg << " as \"#{key}\"" if key_check
      msg << " serialized with #{serializer}" if serializer_check
      msg
    end

    def failure_message
      if association && match_root?
        "expected #{actual} association options for #{root}: #{association.options} to include: #{expected_association}"
      else
        "expected #{actual} associations: #{associations.keys} to include: #{root.inspect}"
      end
    end

    def failure_message_when_negated
      if association && match_root?
        "expected #{actual} associations: #{associations.keys} to not include: #{root.inspect}"
      else
        "expected #{actual} association options for #{root}: #{association.options} to not include: #{expected_options}"
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

    def association
      return false if associations[root].nil?
      associations[root]
    end

    def match_root?
      association.options[:root] == root
    end

    def match_key?
      return true unless key_check
      association.options[:key] == key
    end

    def match_serializer?
      return true unless serializer_check
      association.options[:serializer].to_s == serializer.to_s
    end
  end
end
