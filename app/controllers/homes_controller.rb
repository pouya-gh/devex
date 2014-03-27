class HomesController < ApplicationController
  def index
    if signed_in?
      @posts = Post.where(published: true).reverse
    else
      @posts = Post.where(published: true, pro: false).reverse
    end
  end
end