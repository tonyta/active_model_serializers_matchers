shared_examples 'it has_one :foo' do
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

shared_examples 'it has_one :foo and no key' do
  it 'should fail a have_one :foo as :bar expectation' do
    expect {
      expect(subject).to have_one(:foo).as(:bar)
    }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have key :bar but instead has none")
  end
end

shared_examples 'it has_one :foo and no serializer' do
  it 'should fail a have_one :foo serialized with FooSerializer expectation' do
    expect {
      expect(subject).to have_one(:foo).serialized_with(FooSerializer)
    }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have serializer FooSerializer but instead has none")
  end
end

shared_examples 'it has_one :foo with key :bar' do
  it 'should pass a have_one :foo as :bar expectation' do
    expectation = have_one(:foo).as(:bar)
    expect(subject).to expectation
    expect(expectation.description).to eq('have one :foo as :bar')
  end

  it 'should fail a have_one :foo as :bor expectation' do
    expect {
      expect(subject).to have_one(:foo).as(:bor)
    }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have key :bor but instead was :bar")
  end
end

shared_examples 'it has_one :foo with serializer FooSerializer' do
  it 'should pass a have_one :foo as :bar expectation' do
    expectation = have_one(:foo).serialized_with(FooSerializer)
    expect(subject).to expectation
    expect(expectation.description).to eq('have one :foo serialized with FooSerializer')
  end

  it 'should fail a have_one :foo serialized with FooSerializer expectation' do
    expect {
      expect(subject).to have_one(:foo).serialized_with(BarSerializer)
    }.to fail_with("expected #{ subject } 'has_one :foo' association to explicitly have serializer BarSerializer but instead was FooSerializer")
  end
end

shared_examples 'it has_many :foos' do
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

shared_examples 'it has_many :foos and no key' do
  it 'should fail a have_many :foos as :bars expectation' do
    expect {
      expect(subject).to have_many(:foos).as(:bars)
    }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have key :bars but instead has none")
  end
end

shared_examples 'it has_many :foos and no serializer' do
  it 'should fail a have_many :foos serialized with FooSerializer expectation' do
    expect {
      expect(subject).to have_many(:foos).serialized_with(FooSerializer)
    }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have serializer FooSerializer but instead has none")
  end
end

shared_examples 'it has_many :foos with key :bars' do
  it 'should pass a have_many :foos as :bars expectation' do
    expectation = have_many(:foos).as(:bars)
    expect(subject).to expectation
    expect(expectation.description).to eq('have many :foos as :bars')
  end

  it 'should fail a have_many :foos as :bors expectation' do
    expect {
      expect(subject).to have_many(:foos).as(:bors)
    }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have key :bors but instead was :bars")
  end
end

shared_examples 'it has_many :foos with serializer FooSerializer' do
  it 'should pass a have_many :foos as :bar expectation' do
    expectation = have_many(:foos).serialized_with(FooSerializer)
    expect(subject).to expectation
    expect(expectation.description).to eq('have many :foos serialized with FooSerializer')
  end

  it 'should fail a have_many :foos serialized with FooSerializer expectation' do
    expect {
      expect(subject).to have_many(:foos).serialized_with(BarSerializer)
    }.to fail_with("expected #{ subject } 'has_many :foos' association to explicitly have serializer BarSerializer but instead was FooSerializer")
  end
end
