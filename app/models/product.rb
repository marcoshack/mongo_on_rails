class Product
  include Mongoid::Document

  field :title      , :type => String
  field :description, :type => String
  field :keywords   , :type => Array
  field :quantity   , :type => Integer, default: 0
  field :price      , :type => Float
  field :status     , :type => String

  embeds_many :comments
  belongs_to  :category
  
  validates :title, presence: true, length: { maximum: 100 }
  
  scope :published, where(status: "published")
  scope :available, published.and(:quantity.gt => 0)
  scope :with_keywords, lambda { |words| 
    where(:keywords.all => words)
  }
  scope :commented_by, lambda { |name|
    all.or("comments.author_name"  => name).
        or("comments.author_email" => name)
  }
  
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
