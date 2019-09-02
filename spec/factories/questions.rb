FactoryBot.define do
  factory :question do
    association :author, factory: :user
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      title { nil }
    end
  end
end
