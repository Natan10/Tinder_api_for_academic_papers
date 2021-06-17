require 'faker'

FactoryBot.define do 
  factory :teacher do 
    name { Faker::Name.name }
    sequence :email do |n|
      "person#{n}@example.com"
    end
    latex_url { Faker::Internet.url }
  end

  factory :theme do 
   title { Faker::Lorem.word }
   description {Faker::Lorem.paragraph}
   tags {["A","B","C"].sample(rand(1..3))}
   teacher 
  end
end


