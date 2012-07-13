class Tag
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :products
  
  validates :name, presence: true, uniqueness: true
end

