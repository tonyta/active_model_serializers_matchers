require 'spec_helper'

describe ActiveModelSerializersMatchers::AssociationMatcher do

  describe 'negated expectations' do
    let(:serializer) do
      Class.new(ActiveModel::Serializer) { has_one :foo }
    end

    let(:error_class) { ActiveModelSerializersMatchers::NegatedUseNotSupportedError }
    let(:error_message) { 'negated expectations are not supported by ActiveModelSerializersMatchers' }

    it 'raises an error when expectation is techically true' do
      expect {
        expect(serializer).to_not have_one(:foo)
      }.to raise_error(error_class, error_message)
    end

    it 'raises an error when expectation is techically false' do
      expect {
        expect(serializer).to_not have_one(:fuu)
      }.to raise_error(error_class, error_message)
    end
  end

  context 'when given serializer that has_one :foo' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no key'
    it_behaves_like 'it has_one :foo and no serializer'
    it_behaves_like 'it has_one :foo and no embed_key'
  end

  context 'when given serializer that has_one :foo, key: :bar' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, key: :bar }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no serializer'
    it_behaves_like 'it has_one :foo and no embed_key'
    it_behaves_like 'it has_one :foo with key :bar'
  end

  context 'when given serializer that has_one :foo, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, serializer: FooSerializer }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no key'
    it_behaves_like 'it has_one :foo and no embed_key'
    it_behaves_like 'it has_one :foo with serializer FooSerializer'
  end

  context 'when given serializer that has_one :foo, embed_key: :foo_external_id' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, embed_key: :foo_external_id }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo and no key'
    it_behaves_like 'it has_one :foo and no serializer'
    it_behaves_like 'it has_one :foo with embed_key :foo_external_id'
  end

  context 'when given serializer that has_one :foo, key: :bar, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo, key: :bar, serializer: FooSerializer }
    end
    it_behaves_like 'it has_one :foo'
    it_behaves_like 'it has_one :foo with key :bar'
    it_behaves_like 'it has_one :foo with serializer FooSerializer'

    describe 'should if all chained expectations pass in any order' do
      it 'should pass a have_one :foo as :bar serialized_with FooSerializer expectation' do
        expectation = have_one(:foo).as(:bar).serialized_with(FooSerializer)
        expect(subject).to expectation
        expect(expectation.description).to eq('have one :foo as :bar serialized with FooSerializer')
      end

      it 'should pass a have_one :foo serialized_with FooSerializer as :bar expectation' do
        expectation = have_one(:foo).serialized_with(FooSerializer).as(:bar)
        expect(subject).to expectation
        expect(expectation.description).to eq('have one :foo serialized with FooSerializer as :bar')
      end
    end

    describe 'should fail with the first encountered expectation message if any chained expectations fail' do
      it 'should fail a have_one :fuu expectation' do
        failure_message = "expected #{ subject } to define a 'has_one :fuu' association"
        expect {
          expect(subject).to have_one(:fuu).as(:bar).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:fuu).serialized_with(FooSerializer).as(:bar)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:fuu).as(:bor).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:fuu).serialized_with(BarSerializer).as(:bor)
        }.to fail_with(failure_message)
      end

      it 'should fail a have_one :foo serialized with BarSerializer expectation' do
        failure_message = "expected #{ subject } 'has_one :foo' association to explicitly have serializer BarSerializer but instead was FooSerializer"
        expect {
          expect(subject).to have_one(:foo).as(:bar).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:foo).serialized_with(BarSerializer).as(:bar)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:foo).serialized_with(BarSerializer).as(:bor)
        }.to fail_with(failure_message)
      end

      it 'should fail a have_one :foo as :bor expectation' do
        failure_message = "expected #{ subject } 'has_one :foo' association to explicitly have key :bor but instead was :bar"
        expect {
          expect(subject).to have_one(:foo).serialized_with(FooSerializer).as(:bor)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:foo).as(:bor).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_one(:foo).as(:bor).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
      end
    end
  end

  context 'when given serializer that has_many :foos' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no key'
    it_behaves_like 'it has_many :foos and no serializer'
    it_behaves_like 'it has_many :foos and no embed_key'
  end

  context 'when given serializer that has_many :foos, key: :bars' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, key: :bars }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no serializer'
    it_behaves_like 'it has_many :foos and no embed_key'
    it_behaves_like 'it has_many :foos with key :bars'
  end

  context 'when given serializer that has_many :foos, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, serializer: FooSerializer }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no key'
    it_behaves_like 'it has_many :foos and no embed_key'
    it_behaves_like 'it has_many :foos with serializer FooSerializer'
  end

  context 'when given serializer that has_many :foos, embed_key: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, embed_key: :foo_external_id }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos and no key'
    it_behaves_like 'it has_many :foos and no serializer'
    it_behaves_like 'it has_many :foos with embed_key :foo_external_id'
  end

  context 'when given serializer that has_many :foos, key: :bars, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos, key: :bars, serializer: FooSerializer }
    end
    it_behaves_like 'it has_many :foos'
    it_behaves_like 'it has_many :foos with key :bars'
    it_behaves_like 'it has_many :foos with serializer FooSerializer'

    describe 'should if all chained expectations pass in any order' do
      it 'should pass a have_many :foos as :bars serialized_with FooSerializer expectation' do
        expectation = have_many(:foos).as(:bars).serialized_with(FooSerializer)
        expect(subject).to expectation
        expect(expectation.description).to eq('have many :foos as :bars serialized with FooSerializer')
      end

      it 'should pass a have_many :foos serialized_with FooSerializer as :bars expectation' do
        expectation = have_many(:foos).serialized_with(FooSerializer).as(:bars)
        expect(subject).to expectation
        expect(expectation.description).to eq('have many :foos serialized with FooSerializer as :bars')
      end
    end

    describe 'should fail with the first encountered expectation message if any chained expectations fail' do
      it 'should fail a have_many :fuu expectation' do
        failure_message = "expected #{ subject } to define a 'has_many :fuus' association"
        expect {
          expect(subject).to have_many(:fuus).as(:bars).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:fuus).serialized_with(FooSerializer).as(:bars)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:fuus).as(:bors).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:fuus).serialized_with(BarSerializer).as(:bors)
        }.to fail_with(failure_message)
      end

      it 'should fail a have_many :foos serialized with BarSerializer expectation' do
        failure_message = "expected #{ subject } 'has_many :foos' association to explicitly have serializer BarSerializer but instead was FooSerializer"
        expect {
          expect(subject).to have_many(:foos).as(:bars).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:foos).serialized_with(BarSerializer).as(:bars)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:foos).serialized_with(BarSerializer).as(:bors)
        }.to fail_with(failure_message)
      end

      it 'should fail a have_many :foos as :bors expectation' do
        failure_message = "expected #{ subject } 'has_many :foos' association to explicitly have key :bors but instead was :bars"
        expect {
          expect(subject).to have_many(:foos).serialized_with(FooSerializer).as(:bors)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:foos).as(:bors).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to have_many(:foos).as(:bors).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
      end
    end
  end

  ###

  context 'when given serializer that belongs_to :foo' do
    subject do
      Class.new(ActiveModel::Serializer) { belongs_to :foo }
    end
    it_behaves_like 'it belongs_to :foo'
    it_behaves_like 'it belongs_to :foo and no key'
    it_behaves_like 'it belongs_to :foo and no serializer'
    it_behaves_like 'it belongs_to :foo and no embed_key'
  end

  context 'when given serializer that belongs_to :foo, key: :bar' do
    subject do
      Class.new(ActiveModel::Serializer) { belongs_to :foo, key: :bar }
    end
    it_behaves_like 'it belongs_to :foo'
    it_behaves_like 'it belongs_to :foo and no serializer'
    it_behaves_like 'it belongs_to :foo and no embed_key'
    it_behaves_like 'it belongs_to :foo with key :bar'
  end

  context 'when given serializer that belongs_to :foo, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { belongs_to :foo, serializer: FooSerializer }
    end
    it_behaves_like 'it belongs_to :foo'
    it_behaves_like 'it belongs_to :foo and no key'
    it_behaves_like 'it belongs_to :foo and no embed_key'
    it_behaves_like 'it belongs_to :foo with serializer FooSerializer'
  end

  context 'when given serializer that belongs_to :foo, embed_key: :foo_external_id' do
    subject do
      Class.new(ActiveModel::Serializer) { belongs_to :foo, embed_key: :foo_external_id }
    end
    it_behaves_like 'it belongs_to :foo'
    it_behaves_like 'it belongs_to :foo and no key'
    it_behaves_like 'it belongs_to :foo and no serializer'
    it_behaves_like 'it belongs_to :foo with embed_key :foo_external_id'
  end

  context 'when given serializer that belongs_to :foo, key: :bar, serializer: FooSerializer' do
    subject do
      Class.new(ActiveModel::Serializer) { belongs_to :foo, key: :bar, serializer: FooSerializer }
    end
    it_behaves_like 'it belongs_to :foo'
    it_behaves_like 'it belongs_to :foo with key :bar'
    it_behaves_like 'it belongs_to :foo with serializer FooSerializer'

    describe 'should if all chained expectations pass in any order' do
      it 'should pass a belong_to :foo as :bar serialized_with FooSerializer expectation' do
        expectation = belong_to(:foo).as(:bar).serialized_with(FooSerializer)
        expect(subject).to expectation
        expect(expectation.description).to eq('belong to :foo as :bar serialized with FooSerializer')
      end

      it 'should pass a belong_to :foo serialized_with FooSerializer as :bar expectation' do
        expectation = belong_to(:foo).serialized_with(FooSerializer).as(:bar)
        expect(subject).to expectation
        expect(expectation.description).to eq('belong to :foo serialized with FooSerializer as :bar')
      end
    end

    describe 'should fail with the first encountered expectation message if any chained expectations fail' do
      it 'should fail a belong_to :fuu expectation' do
        failure_message = "expected #{ subject } to define a 'belongs_to :fuu' association"
        expect {
          expect(subject).to belong_to(:fuu).as(:bar).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:fuu).serialized_with(FooSerializer).as(:bar)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:fuu).as(:bor).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:fuu).serialized_with(BarSerializer).as(:bor)
        }.to fail_with(failure_message)
      end

      it 'should fail a belong_to :foo serialized with BarSerializer expectation' do
        failure_message = "expected #{ subject } 'belongs_to :foo' association to explicitly have serializer BarSerializer but instead was FooSerializer"
        expect {
          expect(subject).to belong_to(:foo).as(:bar).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:foo).serialized_with(BarSerializer).as(:bar)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:foo).serialized_with(BarSerializer).as(:bor)
        }.to fail_with(failure_message)
      end

      it 'should fail a belong_to :foo as :bor expectation' do
        failure_message = "expected #{ subject } 'belongs_to :foo' association to explicitly have key :bor but instead was :bar"
        expect {
          expect(subject).to belong_to(:foo).serialized_with(FooSerializer).as(:bor)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:foo).as(:bor).serialized_with(FooSerializer)
        }.to fail_with(failure_message)
        expect {
          expect(subject).to belong_to(:foo).as(:bor).serialized_with(BarSerializer)
        }.to fail_with(failure_message)
      end
    end
  end
end
