# ActiveModelSerializersMatchers
[![Gem Version][gem_version_badge]][rubygems]
[![Travis CI][travis_badge]][travis]
[![Coverage Status][coverage_badge]][coverage]
[![Code Climate][codeclimate_badge]][codeclimate]
### RSpec Matchers for ActiveModel::Serializer Associations

**Note:** This gem requires `"active_model_serializers", "~> 0.8.0"`:
- [v0.8.0](https://github.com/rails-api/active_model_serializers/tree/v0.8.0)
- [v0.8.1](https://github.com/rails-api/active_model_serializers/tree/v0.8.1)
- [v0.8.2](https://github.com/rails-api/active_model_serializers/tree/v0.8.2)
- [v0.8.3](https://github.com/rails-api/active_model_serializers/tree/v0.8.3)

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_serializers_matchers', '0.2.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializers_matchers

### Configure RSpec
``` ruby
RSpec.configure do |config|
  config.include ActiveModelSerializersMatchers, :type => :serializer
end
```

## Usage

### Associations

#### has_one and has_many associations

association matcher: `#have_one` and `#have_many`

``` ruby
class ListSerializer < ActiveModel::Serializer
  has_one :title
  has_many :items
end

RSpec.describe ListSerializer, :type => :serializer do
  subject { described_class }
  it { should have_one(:title) }
  it { should have_many(:items) }
  it { should have_many(:cats) }
end

# ListSerializer
#   should have one :title
#   should have many :items
#   should have many :cats (FAILED - 1)
```

#### key option

option matcher: `#as`

``` ruby
class ShoeRackSerializer < ActiveModel::Serializer
  has_many :shoes, key: :kicks
end

RSpec.describe ShoeRackSerializer, :type => :serializer do
  subject { described_class }
  it { should have_many(:shoes).as(:kicks) }
  it { should have_many(:shoes).as(:ones_and_twos) }
end

# ShoeRackSerializer
#   should have many :shoes as :kicks
#   should have many :shoes as :ones_and_twos (FAILED - 1)
```

#### serializer option

option matcher: `#serialized_with`

``` ruby
class ProductSerializer < ActiveModel::Serializer; end
class SoupCanSerializer < ActiveModel::Serializer; end

class ShoppingCartSerializer < ActiveModel::Serializer
  has_many :items, serializer: ProductSerializer
end

RSpec.describe ShoppingCartSerializer, :type => :serializer do
  subject { described_class }
  it { should have_many(:items).serialized_with(ProductSerializer) }
  it { should have_many(:items).serialized_with(SoupCanSerializer) }
end

# ShoppingCartSerializer
#   should have many :items serialized with ProductSerializer
#   should have many :items serialized with SoupCanSerializer (FAILED - 1)
```

#### chaining multiple matchers

Multiple option matchers can be chained onto an association matcher in any order.

``` ruby
class FoodSerializer < ActiveModel::Serializer; end

class MenuSerializer < ActiveModel::Serializer
  has_many :entrees, key: :dishes, serializer: FoodSerializer
end

RSpec.describe MenuSerializer, :type => :serializer do
  subject { described_class }
  it { should have_many(:entrees).as(:dishes).serialized_with(FoodSerializer) }
  it { should have_many(:entrees).serialized_with(FoodSerializer).as(:dishes) }
end

# MenuSerializer
#   should have many :entrees as :dishes serialized with FoodSerializer
#   should have many :entrees serialized with FoodSerializer as :dishes
```

## Contributing

1. Fork it ( https://github.com/tonyta/active_model_serializers_matchers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[gem_version_badge]: http://img.shields.io/gem/v/active_model_serializers_matchers.svg?style=flat
[rubygems]: http://rubygems.org/gems/active_model_serializers_matchers

[travis_badge]: http://img.shields.io/travis/tonyta/active_model_serializers_matchers.svg?style=flat
[travis]: https://travis-ci.org/tonyta/active_model_serializers_matchers

[coverage_badge]: https://img.shields.io/coveralls/tonyta/active_model_serializers_matchers.svg?style=flat
[coverage]: https://coveralls.io/r/tonyta/active_model_serializers_matchers?branch=objectify-association-matchers

[codeclimate_badge]: https://img.shields.io/codeclimate/github/tonyta/active_model_serializers_matchers.svg?style=flat
[codeclimate]: https://codeclimate.com/github/tonyta/active_model_serializers_matchers
