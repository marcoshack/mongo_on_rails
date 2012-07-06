class Product
  include Mongoid::Document
  field :t, as: :title, :type => String
  field :d, as: :description, :type => String
end

# p = Product.new(title: "Samsung Galaxy S")
# p.attributes #=> { "t" => "Samsung Galaxy S"}
# p.title      #=> "Samsung Galaxy S"


