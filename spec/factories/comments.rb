FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }

    association :user, factory: :user
    association :review, factory: :review
  end
end