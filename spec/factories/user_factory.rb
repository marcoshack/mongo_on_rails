FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}"}
  end
end