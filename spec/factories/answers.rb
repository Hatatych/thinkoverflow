FactoryBot.define do
  factory :answer do
    association :author, factory: :user
    question
    body { "MyText" }

    trait :invalid do
      body { nil }
    end
  end
end
