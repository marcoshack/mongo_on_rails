class Product
  include Mongoid::Document
  field :t, as: :title      , :type => String
  field :d, as: :description, :type => String
  field :k, as: :keywords   , :type => Array
  field :q, as: :quantity   , :type => Integer, default: 0
  field :p, as: :price      , :type => Float
  field :s, as: :status     , :type => String

  embeds_many :comments
  belongs_to  :category
  
  validates :title, presence: true, length: { maximum: 100 }
  
  scope :published, where(status: "published")
  scope :available, published.and(:quantity.gt => 0)
  scope :with_keywords, lambda { |words| 
    where(:keywords.all => words)
  }
  scope :commented_by, lambda { |name|
    where("$or" => [
      { "comments.author_name"  => name },
      { "comments.author_email" => name }
    ])
  }
  
  def add_keywords(keywords)
    self.add_to_set(:k, keywords)
  end
  
  def inc_quantity(increment)
    self.inc(:q, increment)
  end
  
  def self.add_keywords(ids, keywords)
  # Product.where(:id.in => ids).add_to_set(:k, keywords)
    Product.where(:id.in => ids).add_to_set(:k, "$each" => keywords)
  end
end
