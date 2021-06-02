require 'bundler/setup'
require 'minitest/autorun'
require 'mongoid-minitest'
require './models'

class MiniTest::Spec
  include Mongoid::Matchers
end