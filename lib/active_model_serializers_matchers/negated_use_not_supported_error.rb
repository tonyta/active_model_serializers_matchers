module ActiveModelSerializersMatchers
  class NegatedUseNotSupportedError < StandardError
    def initialize
      super('negated expectations are not supported by ActiveModelSerializersMatchers')
    end
  end
end
