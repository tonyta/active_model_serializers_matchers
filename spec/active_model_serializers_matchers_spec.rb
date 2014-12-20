require 'spec_helper'

describe ActiveModelSerializersMatchers do

  describe '#have_many' do
    it 'returns a new AssociationMatcher of type :has_many' do
      expect(described_class::AssociationMatcher)
        .to receive(:new).with(:association_root, :has_many)
        .and_call_original
      expect(have_many(:association_root))
        .to be_a described_class::AssociationMatcher
    end
  end

  describe '#have_one' do
    it 'returns a new AssociationMatcher of type :has_one' do
      expect(described_class::AssociationMatcher)
        .to receive(:new).with(:association_root, :has_one)
        .and_call_original
      expect(have_one(:association_root))
        .to be_a described_class::AssociationMatcher
    end
  end
end
