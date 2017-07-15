class PostsController < ApplicationController

  def index
    @posts = Post.all
    @pabs = @posts.pablish
    #@pibs = Post.drafts
    #respond_to do |format|
    # format.json {  render json: @posts }
   #end
end

  def show
    @post = Post.find(params[:id])
    @post = @post.comments
    respond_to do |format|
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.id = SecureRandom.random_number(99999999)
    respond_to do |format|
    if @post.save
    format.html {redirect_to @post}
     format.json {render json: @post, status: :created, location: @post}
    else
      format.html {render action: "new" }
      format.json {render json: @post.errors, status: :unprocessable_entity}
    end
   end
 end

   def edit
    @post = Post.find(params[:id])
  end
   def update
    @post = Post.find(params[:id])
     respond_to do |format|
      format.json { render json: @post }
    end
   end


  private

   def post_params
     params.require(:post).permit(:title,:user_id)
   end

end
