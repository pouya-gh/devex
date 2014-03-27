class HomesController < ApplicationController
  def index
    if signed_in?
      @posts = Post.where(published: true)
    else
      @posts = Post.where(published: true, pro: false)
    end
  end
end