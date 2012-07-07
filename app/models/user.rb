class User
  include Mongoid::Document
  field :username  , :type => String
  field :first_name, :type => String
  field :last_name , :type => String
  field :password  , :type => String
  
  attr_protected :password
  
  validates :username, presence: true, format: { with: /\A[A-Za-z_]+[0-9]*\z/ }
end
