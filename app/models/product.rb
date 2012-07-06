class Product
  include Mongoid::Document
  field :t, as: :title, :type => String
  field :d, as: :description, :type => String
  
  validates :title, presence: true, length: { maximum: 100 }
end

