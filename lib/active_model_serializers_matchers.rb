Dir[Pathname(__FILE__).join('../**/*.rb')].each { |f| require f }

module ActiveModelSerializersMatchers
  def self.included(base)
    base.subject { described_class }
    metadata[:type] = :serializer
  end

  def have_many(association_root)
    AssociationMatcher.new(association_root, :has_many)
  end

  def have_one(association_root)
    AssociationMatcher.new(association_root, :has_one)
  end
end
