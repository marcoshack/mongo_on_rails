class Product
  include Mongoid::Document
  field :title      , :type => String
  field :description, :type => String
  field :keywords   , :type => Array
  field :quantity   , :type => Integer, default: 0
  field :price      , :type => Float
  
  validates :title, presence: true, length: { maximum: 100 }
  
  def add_keywords(keywords)
    self.add_to_set(:keywords, keywords)
    self.save
    self
  end
  
  def inc_quantity(increment)
    self.inc(:quantity, increment)
    self.save
    self
  end
end
