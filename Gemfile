source "https://rubygems.org"

gem "sinatra"
gem "sinatra-contrib"
gem "sinatra-cross_origin", "~> 0.3.1"
gem "mongoid", "~> 7.0"
gem "rack"
gem "rake"
gem "rack-contrib"

gem 'dotenv-rails', groups: [:development, :test]

group :development do
  gem "pry"
end

group :test do 
  gem "minitest"
  gem "minitest-matchers"
  gem "minitest-activemodel"
  gem "mongoid-minitest"
  gem "rack-test"
  gem "factory_bot"
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
end