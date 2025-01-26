FactoryBot.define do
  factory :notification do
    association :user
    association :notifiable, factory: :comment

    trait :for_comment do
      association :notifiable, factory: :comment
    end

    trait :for_favorite do
      association :notifiable, factory: :favorite
    end
  end
end