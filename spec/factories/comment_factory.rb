FactoryGirl.define do
  factory :comment do
    sequence(:author_name) { |n| "User #{n}" }
    author_email { |c| "#{c.author_name.gsub(/ +/,"_").downcase}@example.com" }
    content "lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam"
  end
end