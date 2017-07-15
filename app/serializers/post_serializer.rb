class PostSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :title

  has_many :comments
  class CommentSerializer < ActiveModel::Serializer
    attributes :content
    belongs_to :post
  end
end
