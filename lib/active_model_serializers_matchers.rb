require "active_model_serializers_matchers/version"
require "active_model_serializers_matchers/association_matcher"
require "active_model_serializers_matchers/negated_use_not_supported_error"

module ActiveModelSerializersMatchers

  def have_many(association_root)
    AssociationMatcher.new(association_root, :has_many)
  end

  def have_one(association_root)
    AssociationMatcher.new(association_root, :has_one)
  end
end
