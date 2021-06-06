require 'bundler/setup'
require 'mongoid'
require 'minitest/autorun'
require 'mongoid-minitest'
require 'rack/test'
require 'factory_bot'
require './models'
require './server'

#factories
require_relative 'factories'

configure do
  Mongoid.load!("./config/db/mongoid.yml","test")
end

class MiniTest::Spec
  include Mongoid::Matchers
  include FactoryBot::Syntax::Methods
  include MiniTest::Matchers::ActiveModel
end