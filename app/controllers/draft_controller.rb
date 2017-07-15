class DraftController < ApplicationController

 def index
   @pibs = Post.drafts
   #@pibs = Draft.find_each do |draft|
     #draft.draft_copy
   # draft.limit_post_publish
  #end
 @pubs = Draft.all
 end

end
