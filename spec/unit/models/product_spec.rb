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
    product.add_keywords(["foo", "bar", "baz", "qux"])
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

  it "should find published products" do
    2.times { create(:product, status: "published") }
    Product.published.count.should == 2
  end
  
  it "shoud find available products" do
    3.times { create(:product, status: "published", quantity: 2) }
    2.times { create(:product, status: "published", quantity: 0) }
    2.times { create(:product, status: "pending"  , quantity: 3) }
    Product.available.count.should == 3
  end
  
  it "should find products with the given keywords" do
    create(:product, keywords: ["awesome"])
    Product.with_keywords(["awesome"])
  end
  
  it "should have comments" do
    product = create(:product_with_comments)    
    product.comments.count.should > 1
  end
  
  it "should find by comment's author's name or e-mail" do
    create(:product, comments: [build(:comment, author_name: "foo")])
    create(:product, comments: [build(:comment, author_email: "bar@example.com")])
    Product.commented_by("foo").count.should == 1
    Product.commented_by("bar@example.com").count.should == 1
  end
  
  it "should have a category" do
    p = create(:product, category: create(:category, name: "A Category"))
    p.category.should_not be_nil
    p.category.name.should == "A Category"
  end
end
