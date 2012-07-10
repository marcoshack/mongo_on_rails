FactoryGirl.define do
  factory :product do
    sequence(:title)    { |n| "Product #{n}" }
    description         { |p| "#{p.title} description" }
    keywords            ["foo", "bar"]
    quantity            1
    price               10.99
    status              "published"
    association         :category
  end
  
  factory :product_with_comments, :parent => :product do
    comments {[
      FactoryGirl.build(:comment),
      FactoryGirl.build(:comment),
      FactoryGirl.build(:comment)
    ]}
  end
end
