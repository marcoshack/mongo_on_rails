require "spec_helper"

describe Product do
  it "should validate title" do
    product = Product.new
    product.valid?.should be_false
    product.errors[:title].should == ["can't be blank"]
    product.save.should be_false
    lambda { product.save! }.should raise_error Mongoid::Errors::Validations
  end
end

# Exemplos usados na apresentacao

# product = Product.new
# product.valid?         #=> false
# product.errors[:title] #=> ["can't be blank"]
# product.save           #=> false
# product.save!          #=> Mongoid::Errors::Validations
#
#
# product = Product.create(title: "Super Nintendo NES System")
# product.attributes #=> { "t" => "Super Nintendo NES System" }
# product.title      #=> "Super Nintendo NES System"
# 
# 
# product = Product.create(title: "Atari 2600")
# 
# product.price                          #=> NoMethodError
# product[:price]                        #=> nil
# product.read_attribute(:price)         #=> nil
# 
# product.price   = 59.99                #=> NoMethodError
# product[:price] = 59.99                #=> OK
# product.write_attribute(:price, 59.99) #=> OK

