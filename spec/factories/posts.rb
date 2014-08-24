# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    association :admin
    sequence(:title) { |n| "Title#{n}" }
    sequence(:digest) { |n| "Digest#{n}" * 3 }
    sequence(:body) { |n| "Title#{n}" * 10 }
    sequence(:tags) { |n| ["tag#{n}", "tag#{n + 1}", "tag#{n + 2}"] }
  end
end
