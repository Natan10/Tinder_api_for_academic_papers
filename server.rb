require "sinatra"
require "mongoid"
require "rack/contrib"
require "sinatra/cross_origin"
require "bundler"
require "./controllers"
Bundler.require(:default)

use Rack::JSONBodyParser

configure do
  Mongoid.load!("./config/db/mongoid.yml","development")
end

configure do
  set :json_encoder, :to_json
  set :allow_origin, :any
  set :allow_methods, [:get, :post, :options, :delete, :put, :patch]
  enable :cross_origin
end

options "*" do
  response.headers["Allow"] = "HEAD,GET,PUT,PATCH,POST,OPTIONS,DELETE"
  response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
end
