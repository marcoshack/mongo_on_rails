class Product
  include Mongoid::Document
  field :t, as: :title, :type => String
  field :d, as: :description, :type => String
  field :k, as: :keywords, :type => Array
  field :q, as: :quantity, :type => Integer, default: 0
  
  validates :title, presence: true, length: { maximum: 100 }
  
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
end
