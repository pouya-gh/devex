class PostsController < ApplicationController
  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    begin 
      @post.save!
      flash[:success] = I18n.translate('post.submit.success')
      redirect_to current_user
    rescue ActiveRecord::RecordInvalid
      flash.now[:danger] = I18n.translate('post.submit.fail')
      render :new
    end
  end

  private

  def post_params
    params.require('post').permit(:title, :body)
  end
end