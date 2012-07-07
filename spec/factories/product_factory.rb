FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Product #{n}" }
    description { |p| "#{p.title} description" }
    keywords ["foo", "bar"]
  end
end