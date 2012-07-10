require "spec_helper"

describe Category do
  it "should have many products" do
    category = create(:category)
    3.times { category.products << create(:product) }
    category.products.size.should == 3
  end
  
  it "should validate name uniquness" do
    create(:category, name: "Category")
    lambda { create(:category, name: "Category") }.should raise_error
  end
end