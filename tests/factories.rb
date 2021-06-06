require 'faker'

FactoryBot.define do 
  factory :teacher do 
    name { Faker::Name.name }
    sequence :email do |n|
      "person#{n}@example.com"
    end
    latex_url { Faker::Internet.url }
  end
end

