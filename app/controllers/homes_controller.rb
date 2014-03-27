class HomesController < ApplicationController
  def index
    if signed_in?
      @posts = Post.where(published: true).order('id DESC')
      .page(params[:page]).per(4)
      # .reverse
    else
      @posts = Post.where(published: true, pro: false).order('id DESC')
      .page(params[:page]).per(4)
      # .reverse
    end
  end
end