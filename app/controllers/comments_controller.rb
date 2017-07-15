class CommentsController < ApplicationController


  def index
    @comments = Comment.all
    respond_to do |format|
      format.json { render json: @comments }
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.json { render json: @comment }
    end
  end

end
