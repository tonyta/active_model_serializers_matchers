require 'spec_helper'

describe ActiveModelSerializersMatchers::HaveOneAssociationMatcher do

  subject { described_class.new(:foos) }

  let(:serializer) { Class.new(ActiveModel::Serializer) }

  describe '#matches?' do
    context 'when called with a class' do
      it 'sets @actual to that class' do
        allow(subject).to receive(:root_association)
        subject.matches?(Object)
        expect(subject.actual).to be Object
      end
    end

    context 'when called with an instance of class' do
      it 'sets @actual to the class of that instance' do
        allow(subject).to receive(:root_association)
        subject.matches?(Object.new)
        expect(subject.actual).to be Object
      end
    end

    describe 'return value' do
      context 'when match_association?, match_key?, and match_serializer? are all true' do
        before do
          expect(subject).to receive(:match_association?) { true }
          expect(subject).to receive(:match_key?        ) { true }
          expect(subject).to receive(:match_serializer? ) { true }
        end
        specify { expect(subject.matches?(serializer)).to be true }
      end

      context 'when any match_association?, match_key?, or match_serializer? is false' do
        match_check_methods = [:match_association?, :match_key?, :match_serializer?]

        match_check_methods.each do |false_method|
          before do
            match_check_methods.each do |method|
              allow(subject).to receive(method) { method == false_method ? false : true }
            end
          end
          specify { expect(subject.matches?(serializer)).to be false }
        end
      end
    end
  end

  describe '#as' do
    it 'should return self' do
      expect(subject.as(:a_key)).to be subject
    end

    context 'when it is not called' do
      its(:key_check) { should be false }
      its(:key) { should be_nil }
    end

    context 'when it is called with :a_key' do
      before { subject.as(:a_key) }
      its(:key_check) { should be true }
      its(:key) { should be :a_key }
    end
  end

  describe '#serialized_with' do
    it 'should return self' do
      expect(subject.serialized_with(:a_serializer)).to be subject
    end

    context 'when it is not called' do
      its(:serializer_check) { should be false }
      its(:serializer) { should be_nil }
    end

    context 'when it is called with :a_serializer' do
      before { subject.serialized_with(:a_serializer) }
      its(:serializer_check) { should be true }
      its(:serializer) { should be :a_serializer }
    end
  end

  describe 'feature tests' do
    include ActiveModelSerializersMatchers

    context 'a serializer with one foo' do
      subject do
        Class.new(ActiveModel::Serializer) { has_many :foos }
      end
      it { should_not have_one :foo  }
      it { should_not have_one :foos }
    end

    context 'a serializer with one foo' do
      subject do
        Class.new(ActiveModel::Serializer) { has_one :foo }
      end
      it { should     have_one(:foo) }
      it { should_not have_one(:bar) }
      it { should_not have_one(:foo).as(:bar) }
      it { should_not have_one(:foo).serialized_with(:baz) }
    end

    context 'a serializer with one foo as bar' do
      subject do
        Class.new(ActiveModel::Serializer) { has_one :foo, key: :bar }
      end
      it { should     have_one(:foo) }
      it { should     have_one(:foo).as(:bar) }
      it { should_not have_one(:foo).as(:baz) }
    end

    context 'a serializer with one foo serialized with baz' do
      subject do
        Class.new(ActiveModel::Serializer) { has_one :foo, serializer: :baz }
      end
      it { should     have_one(:foo) }
      it { should     have_one(:foo).serialized_with(:baz) }
      it { should_not have_one(:foo).serialized_with(:bar) }
    end

    context 'a serializer with one foo as bar serialized with baz' do
      subject do
        Class.new(ActiveModel::Serializer) { has_one :foo, key: :bar, serializer: :baz }
      end
      it { should     have_one(:foo) }
      it { should     have_one(:foo).as(:bar) }
      it { should     have_one(:foo).serialized_with(:baz) }
      it { should     have_one(:foo).as(:bar).serialized_with(:baz) }
      it { should_not have_one(:fuu).as(:bar).serialized_with(:baz) }
      it { should_not have_one(:foo).as(:bor).serialized_with(:baz) }
      it { should_not have_one(:foo).as(:bar).serialized_with(:biz) }
    end
  end
end
