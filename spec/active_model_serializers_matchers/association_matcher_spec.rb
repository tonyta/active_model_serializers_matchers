require 'spec_helper'

describe ActiveModelSerializersMatchers::AssociationMatcher do

  include ActiveModelSerializersMatchers

  context 'when given serializer that has_one :foo' do
    subject do
      Class.new(ActiveModel::Serializer) { has_one :foo }
    end

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

  context 'when given serializer that has_many :foos' do
    subject do
      Class.new(ActiveModel::Serializer) { has_many :foos }
    end

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
end
