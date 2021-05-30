require "sinatra"
require "mongoid"
require "sinatra/json"
require "bundler"
require "./controllers"

#Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

Bundler.require(:default)

configure do
  Mongoid.load!("./config/mongoid.yml")
end

