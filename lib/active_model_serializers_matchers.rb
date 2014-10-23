require "active_support"

require "active_model_serializers_matchers/version"
require "active_model_serializers_matchers/have_many_association_matcher"

module ActiveModelSerializersMatchers
  extend ActiveSupport::Concern

  included do
    subject { described_class }
  end
end
