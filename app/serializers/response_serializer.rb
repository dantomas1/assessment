class ResponseSerializer < ActiveModel::Serializer
  attributes 
   belongs_to :poster
   has_many :posts
end
