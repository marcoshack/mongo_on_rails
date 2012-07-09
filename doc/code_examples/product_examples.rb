
# Validations

product = Product.new
product.valid?         #=> false
product.errors[:title] #=> ["can't be blank"]
product.save           #=> false
product.save!          #=> Mongoid::Errors::Validations


# Dynamic Attributes

product = Product.create(title: "Super Nintendo NES System")
product.attributes #=> { "t" => "Super Nintendo NES System" }
product.title      #=> "Super Nintendo NES System"


product = Product.create(title: "Atari 2600")

product.price                          #=> NoMethodError
product[:price]                        #=> nil
product.read_attribute(:price)         #=> nil

product.price   = 59.99                #=> NoMethodError
product[:price] = 59.99                #=> OK
product.write_attribute(:price, 59.99) #=> OK


# Criteria chains

Product.where(:quantity.gt => 1).in(keywords: ["game","console"]).order(title: 1)

@products = Product.all.order(params[:o] || :title => 1)
@products = @products.gte(quantity: params[:q]) if params[:q].present?
@products = @products.in(keywords: params[:k].split(",")) if params[:k].present?

@products.each do |product|
  # ...
end


# Criteria + Modificações

Product.where(quantity: 0).destroy_all

Product.where(:keywords.all => ["game", "console"]).update_all(
  category: "Video Game"
)

