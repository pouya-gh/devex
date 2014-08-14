# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:first_name) { |n| "pouya#{n}" }
    sequence(:last_name) { |n| "test#{n}" }
    sequence(:email) { |n| "pouya#{n}@mail.com" }
    password "123456"
    password_confirmation "123456"
  end
end
