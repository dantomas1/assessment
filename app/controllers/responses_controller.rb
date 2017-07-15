class ResponsesController < ApplicationController

  def  index
    responses = Response.for_user(User.first)
    render json: responses
  end

end
