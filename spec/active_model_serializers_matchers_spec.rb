require 'spec_helper'

describe ActiveModelSerializersMatchers do

  include described_class

  describe '#have_many' do
    it 'instantiates a new HaveManyAssociationMatcher' do
      expect(described_class::HaveManyAssociationMatcher)
        .to receive(:new).with(:association_root)
      have_many(:association_root)
    end
  end

  describe '#have_one' do
    it 'instantiates a new HaveOneAssociationMatcher' do
      expect(described_class::HaveOneAssociationMatcher)
        .to receive(:new).with(:association_root)
      have_one(:association_root)
    end
  end
end
