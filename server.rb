require "sinatra"
require "mongoid"
require "sinatra/json"
require "bundler"
require "./controllers"

Bundler.require(:default)

configure do
  Mongoid.load!("./config/mongoid.yml")
end

