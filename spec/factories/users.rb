FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  sequence :username do |n|
    "Username#{n}"
  end

  factory :user do
    email
    username
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
