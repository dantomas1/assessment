class Draft < Post

   scope :drafted, -> () { Post.where(status: "published").limit(3).update_all(status: "draft")}
   scope :drafta, -> () {update_all(status: "draft")}
   scope :drafts, lambda {where(status: "published").limit(2).update_all(status: "draft")} 
  def draft_copy
    Post.where(status: "publish").limit(2).update_all(status: "draft")
    puts "after => #{Post.where(status: "publish").count}"
  end
  def limit_post_publish
    if (Post.where(status: "publish").count > 3)
      puts "before => #{Post.where(status: "publish").count}"
      puts "offset count -> #{Post.where(status: "publish").offset(3).count}"
      Post.where(status: "publish").limit(2).update_all(status: "draft")
      # News.where(frontpage: true).offset(30).each do |news|
         #   news.update_column(:frontpage, false)
       # end
        puts "after => #{Post.where(status: "publish").count}"
       end
     end
end
