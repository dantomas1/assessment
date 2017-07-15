class GlovesController < ApplicationController

  def index
    @dups = Glove.duplis
  end

end
