class Product
  include Mongoid::Document
  field :title      , :type => String
  field :description, :type => String
  field :keywords   , :type => Array
  field :quantity   , :type => Integer, default: 0
  field :price      , :type => Float
  field :category   , :type => String
  field :status     , :type => String
  
  validates :title, presence: true, length: { maximum: 100 }
  
  scope :published, where(status: "published")
  
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
