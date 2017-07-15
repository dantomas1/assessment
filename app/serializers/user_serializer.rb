class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
  has_many :posts

  class PostSerializer < ActiveModel::Serializer
    attributes :user_id, :title, :comments
    belongs_to :user

  end
  #has_many :comments
end
