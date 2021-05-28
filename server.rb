require "sinatra"
require "sinatra/json"
require "mongoid"
require "bundler"
require "./controller"


Bundler.require(:default)

Mongoid.load!(File.join(File.dirname(__FILE__), 'config', 'mongoid.yml'))
# configure :development do
# end

