# encoding: utf-8

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "عارف"
    last_name "اصلانی"
    email "arefaslani@gmail.com"
    password "12345678"
    password_confirmation "12345678"
  end
end
