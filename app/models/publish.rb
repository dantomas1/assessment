class Publish < Post

  scope :published, -> () { Post.where(status: "draft").update_all(status: "publish")}
  
end
