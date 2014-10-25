# ActiveModelSerializersMatchers

RSpec matchers for testing ActiveModel::Serializer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_model_serializers_matchers', '0.0.1',
  git: 'git://github.com/tonyta/active_model_serializers_matchers.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_model_serializers_matchers

## Usage
### Simple `has_many` and `has_one` Associations
``` ruby
class ListSerializer < ActiveModel::Serializer
  has_one :title
  has_many :items
end

RSpec.describe ListSerializer do
  it { should have_one(:title) }
  it { should have_many(:items) }
end

#=> should have one title
#=> should have many items
```

### Association Options
#### Key
use: `#as`
``` ruby
class ShoeRackSerializer < ActiveModel::Serializer
  has_many :shoes, key: :kicks
end

RSpec.describe ShoeRackSerializer do
  it { should have_many(:shoes).as(:kicks) }
end

#=> should have many shoes as "kicks"
```
#### Serializer
use: `#serialized_with`
``` ruby
class ShoppingCartSerializer < ActiveModel::Serializer
  has_many :items, serializer: ProductSerializer
end

RSpec.describe ShoppingCartSerializer do
  it { should have_many(:items).serialized_with(ProductSerializer) }
end

#=> should have many items serialized with ProductSerializer
```
#### Chainable
These can be chained in any order.
``` ruby
class MenuSerializer < ActiveModel::Serializer
  has_many :entrees, key: dishes, serializer: FoodSerializer
end

RSpec.describe MenuSerializer do
  it { should have_many(:entrees).as(:dishes).serialized_with(FoodSerializer) }
  it { should have_many(:entrees).serialized_with(FoodSerializer).as(:dishes) }
end

#=> should have many entrees as "dishes" serialized with FoodSerializer
#=> should have many entrees as "dishes" serialized with FoodSerializer
```

## Contributing

1. Fork it ( https://github.com/tonyta/active_model_serializers_matchers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
