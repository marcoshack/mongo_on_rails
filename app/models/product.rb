class Product
  include Mongoid::Document

  field :title      , :type => String
  field :description, :type => String
  field :keywords   , :type => Array
  field :quantity   , :type => Integer, default: 0
  field :price      , :type => Float
  field :status     , :type => String
  
  index :title
  index :status
  index :keywords, sparce: true
  index([
    [ :status  , Mongo::ASCENDING ],
    [ :quantity, Mongo::ASCENDING ]
  ])
  index "comments.author_email"

  embeds_many :comments
  belongs_to  :category
  has_and_belongs_to_many :tags
  
  validates :title, presence: true, length: { maximum: 100 }
  
  scope :published, where(status: "published")
  scope :available, where(:quantity.gt => 0).and.published
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
    self.add_to_set(:keywords, keywords)
  end
  
  def inc_quantity(increment)
    self.inc(:quantity, increment)
  end
  
  def self.keyword_counter
    map = %Q{
      function() {
        if (this.keywords != null) {
          this.keywords.forEach(function(keyword) {
            emit(keyword, {count: 1})
          })
        }
      }
    }
    
    reduce = %Q{
      function(key, values) {
        var result = {count: 0}
        values.forEach(function(value) {
          result.count += value.count
        })
        return result;
      }
    }
    
    options = { 
        out: { inline: 1 }, raw: true,
      query: Product.available.selector
    }

    output  = Product.collection.map_reduce(map, reduce, options)
    counter = {}
        
    output["results"].each do |item|
      counter[item["_id"]] = item["value"]["count"]
    end if output ["ok"] == 1

    return counter
  end
  
end
