# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :admin
    sequence(:title) { |n| "Title#{n}" }
    sequence(:digest) { |n| "Digest#{n}" * 3 }
    sequence(:body) { |n| "Title#{n}" * 10 }
  end
end
