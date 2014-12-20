require 'spec_helper'

describe ActiveModelSerializersMatchers::AssociationMatcher do

  include ActiveModelSerializersMatchers

  context 'when given serializer that has_one :foo' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no key'
    it_behaves_like 'it has_one :foo and no serializer'
  end

  context 'when given serializer that has_one :foo, key: :bar' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, key: :bar }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no serializer'
    it_behaves_like 'it has_one :foo with key :bar'
  end

  context 'when given serializer that has_one :foo, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, serializer: FooSerializer }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no key'
    it_behaves_like 'it has_one :foo with serializer FooSerializer'
  end

  context 'when given serializer that has_many :foos' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no key'
    it_behaves_like 'it has_many :foos and no serializer'
  end

  context 'when given serializer that has_many :foos, key: :bars' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, key: :bars }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no serializer'
    it_behaves_like 'it has_many :foos with key :bars'
  end

  context 'when given serializer that has_many :foos, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, serializer: FooSerializer }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no key'
    it_behaves_like 'it has_many :foos with serializer FooSerializer'
  end
end
