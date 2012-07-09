FactoryGirl.define do
  factory :product do
    sequence(:title)    { |n| "Product #{n}" }
    description         { |p| "#{p.title} description" }
    keywords            ["foo", "bar"]
    quantity            1
    price               10.00
    sequence(:category) { |n| "Category #{n}" }
    status              "published"
  end
end