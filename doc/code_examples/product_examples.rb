
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


# Named scopes

class Product
  # ...
  scope :published    , where(status: "published")
  scope :available    , where(:quantity.gt => 0).and.published
  scope :unavailable  , where(:quantity => 0)
  scope :with_keywords, lambda { |words| 
    where(:keywords.all => words)
  }
  # ...
end

Product.available.with_keywords(["awesome", "game"])


# Criteria + Modificações

 Product.unavailable.destroy_all

Product.with_keywords(["game","console"]).update_all(
  category: "Video Game"
)


# Embedded Association

class Product
  # ...
  embeds_many :comments
  # ...
end


product.comments << Comment.new(
   author_name: "Roger Federer",
  author_email: "number_one@atp.com",
       content: "Amazing site! I'll buy my rackets here!"
)

product.comments.create(
   author_name: "Roger Federer",
  author_email: "number_one@atp.com",
       content: "Amazing site! I'll buy my rackets here!"
)

product.comments.destroy_all
product.comments.where(author_name: "Spammer").destroy_all

class Product
  # ...
  scope :commented_by, lambda { |name|
    all.or("comments.author_name"  => name).
        or("comments.author_email" => name)
  }
  #...
end

Product.where("comments.author_name" => "Miyamoto")


# Referenced Association

class Product
  # ...
  belongs_to  :category
  # ...
end



