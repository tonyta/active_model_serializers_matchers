require 'spec_helper'

class FooSerializer
end

describe ActiveModelSerializersMatchers::AssociationMatcher do

  include ActiveModelSerializersMatchers

  context 'when given serializer that has_one :foo' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo }
    end

    describe 'association expectation' do
      it 'should pass a have_one :foo expectation' do
        expectation = have_one(:foo)
        expect(subject).to expectation
        expect(expectation.description).to eq('have one :foo')
      end

      it 'should fail a have_one :fuu expectation' do
        expect {
          expect(subject).to have_one(:fuu)
        }.to fail_with("expected #{ subject } to define a 'has_one :fuu' association")
      end

      it 'should fail a have_many :foo expectation' do
        expect {
          expect(subject).to have_many(:foo)
        }.to fail_with("expected #{ subject } to define a 'has_many :foo' association")
      end
    end

    describe 'key expectation' do
      it 'should fail a have_one :foo as :bar expectation' do
        expect {
          expect(subject).to have_one(:foo).as(:bar)
        }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have key :bar but instead has none")
      end
    end

    describe 'serializer expectation' do
      it 'should fail a have_one :foo serialized with FooSerializer expectation' do
        expect {
          expect(subject).to have_one(:foo).serialized_with(FooSerializer)
        }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have serializer FooSerializer but instead has none")
      end
    end
  end

  context 'when given serializer that has_many :foos' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos }
    end

    describe 'association expectation' do
      it 'should pass a have_many :foos expectation' do
        expectation = have_many(:foos)
        expect(subject).to expectation
        expect(expectation.description).to eq('have many :foos')
      end

      it 'should fail a have_many :fuus expectation' do
        expect {
          expect(subject).to have_many(:fuus)
        }.to fail_with("expected #{ subject } to define a 'has_many :fuus' association")
      end

      it 'should fail a have_one :foos expectation' do
        expect {
          expect(subject).to have_one(:foos)
        }.to fail_with("expected #{ subject } to define a 'has_one :foos' association")
      end
    end

    describe 'key expectation' do
      it 'should fail a have_many :foos as :bars expectation' do
        expect {
          expect(subject).to have_many(:foos).as(:bars)
        }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have key :bars but instead has none")
      end
    end

    describe 'serializer expectation' do
      it 'should fail a have_many :foos serialized with FooSerializer expectation' do
        expect {
          expect(subject).to have_many(:foos).serialized_with(FooSerializer)
        }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have serializer FooSerializer but instead has none")
      end
    end
  end
end
