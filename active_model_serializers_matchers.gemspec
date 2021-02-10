# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_serializers_matchers/version'

Gem::Specification.new do |spec|
  spec.name          = "active_model_serializers_matchers"
  spec.version       = ActiveModelSerializersMatchers::VERSION
  spec.authors       = ["Tony Ta"]
  spec.email         = ["tonyta.tt@gmail.com"]
  spec.description   = "RSpec Matchers for ActiveModel::Serializer Associations"
  spec.summary       = "These matchers will allow you to test associations between serializers."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "active_model_serializers", "0.10.10"
  spec.add_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "coveralls"
end
