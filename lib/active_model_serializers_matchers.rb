require "active_support"

require "active_model_serializers_matchers/version"
require "active_model_serializers_matchers/association_matcher"

module ActiveModelSerializersMatchers
  extend ActiveSupport::Concern

  included do
    subject { described_class }
  end

  def have_many(association_root)
    AssociationMatcher.new(root: association_root, type: :has_many)
  end

  def have_one(association_root)
    AssociationMatcher.new(root: association_root, type: :has_one)
  end
end
