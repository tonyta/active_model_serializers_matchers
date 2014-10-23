require "active_support"

require "active_model_serializers_matchers/version"
require "active_model_serializers_matchers/have_many_association_matcher"

module ActiveModelSerializersMatchers
  extend ActiveSupport::Concern

  included do
    subject { described_class }
  end

  def have_many(association_root)
    HaveManyAssociationMatcher.new(association_root)
  end
end
