require 'pathname'
Dir[Pathname(__FILE__).join('../**/*.rb')].each { |f| require f }

module ActiveModelSerializersMatchers
  def belong_to(association_root)
    AssociationMatcher.new(association_root, :belongs_to)
  end

  def have_many(association_root)
    AssociationMatcher.new(association_root, :has_many)
  end

  def have_one(association_root)
    AssociationMatcher.new(association_root, :has_one)
  end
end
