class Post < ActiveRecord::Base

 belongs_to :user
 has_many :comments

 scope :publis, ->() {where(status: "draft").update_all(status: "publish")}
 scope :drafts, ->() {where(status: "publish").limit(2).update_all(status: "draft")} 
scope :pablish, -> () { where(status: "publish")} 
 #scope :published, -> () { where(status: "published").update_all(status: "draft")} 

end

