require 'pry-byebug'
require 'rspec/its'
require 'active_model_serializers'
require 'active_model_serializers_matchers'

Dir[Pathname(__FILE__).join('../support/**/*.rb')].each { |f| require f }
