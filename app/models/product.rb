class Product
  include Mongoid::Document
  field :t, as: :title      , :type => String
  field :d, as: :description, :type => String
  field :k, as: :keywords   , :type => Array
  field :q, as: :quantity   , :type => Integer, default: 0
  field :p, as: :price      , :type => Float
  field :c, as: :category   , :type => String
  field :s, as: :status     , :type => String
  
  validates :title, presence: true, length: { maximum: 100 }
  
  scope :published, where(status: "published")
  
  def add_keywords(keywords)
    self.add_to_set(:k, keywords)
    self.save
    self
  end
  
  def inc_quantity(increment)
    self.inc(:q, increment)
    self.save
    self
  end
  
  def self.add_keywords(ids, keywords)
  # Product.where(:id.in => ids).add_to_set(:k, keywords)
    Product.where(:id.in => ids).add_to_set(:k, "$each" => keywords)
  end
end
