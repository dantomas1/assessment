class PublishController < ApplicationController

 def index
  @pibs = Publish.published
  @pubs = Publish.all
 end

end
