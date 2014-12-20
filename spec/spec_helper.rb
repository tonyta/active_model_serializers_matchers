require 'coveralls'
Coveralls.wear!

require 'active_model_serializers'
require 'active_model_serializers_matchers'

Dir[Pathname(__FILE__).join('../support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include ActiveModelSerializersMatchers
end
