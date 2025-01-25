FactoryBot.define do
  factory :review do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:30) }
    rating { rand(1..5) }

    association :user
    association :hut
  end
end