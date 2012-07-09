require "spec_helper"

describe Product do
  it "should validate title" do
    product = Product.new
    product.valid?.should be_false
    product.errors[:title].should == ["can't be blank"]
    product.save.should be_false
    lambda { product.save! }.should raise_error Mongoid::Errors::Validations
  end
  
  it "should add keywords without duplication" do
    product = create(:product, keywords: ["foo", "bar"])
    product.add_keywords(["foo", "bar", "baz", "qux"]).reload
    product.keywords.should == ["foo", "bar", "baz", "qux"]
  end
  
  it "should do nothing when adding nil or empty keywords" do
    product = create(:product, keywords: ["foo", "bar"])
    product.add_keywords(nil)
    product.add_keywords([])
    product.keywords.should == ["foo", "bar"]
  end
  
  it "should increment quantity" do
    product = create(:product, quantity: 3)
    product.inc_quantity(2)
    product.quantity.should == 5
  end
  
  it "should have price" do
    product = create(:product)
    product.price = 19.99
    product.save
    product.reload
    product.price.should == 19.99
  end
  
  it "should add keywords for a set of products" do
    ids = []
    3.times { ids << create(:product, keywords: ["foo", "bar"]).id }
    Product.add_keywords(ids, ["baz", "qux"])
    Product.find(ids).each { |p| p.keywords.should == ["foo", "bar", "baz", "qux"] }
  end
end
