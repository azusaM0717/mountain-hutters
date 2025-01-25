FactoryBot.define do
  factory :hut do
    name { Faker::Lorem.words(number: 3).join(' ') }
    description { Faker::Lorem.paragraph }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
