class PostsController < ApplicationController
  before_filter :check_admin, except: [:index]

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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:success] = I18n.translate('post.update.success')
    redirect_to current_user
  end

  def destroy
    Post.find(params[:id]).destroy!
    flash[:success] = I18n.translate('post.delete.success')
    redirect_to current_user
  end

  private

  def post_params
    params.require('post').permit(:title, :body, :pro, :digest)
  end

  private

  def check_admin
    unless current_user.admin?
      flash[:danger] = I18n.translate('post.not_authorized')
      redirect_to current_user
    end
  end
end