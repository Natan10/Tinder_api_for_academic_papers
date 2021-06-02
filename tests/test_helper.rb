require 'bundler/setup'
require 'minitest/autorun'
require 'mongoid-minitest'
require 'rack/test'
require './models'
require './server'

class MiniTest::Spec
  include Mongoid::Matchers
end