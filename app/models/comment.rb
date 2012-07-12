class Comment
  include Mongoid::Document

  field :author_name , type: String
  field :author_email, type: String
  field :content     , type: String

  embedded_in :product
end
