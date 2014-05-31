class PostsController < ApplicationController
  before_filter :check_admin, except: [:index]

  def new
    @post = current_user.posts.new
    render layout: 'admin'
  end

  def create
    @post = current_user.posts.new(post_params)
    begin 
      @post.save!
      flash[:success] = I18n.translate('post.submit.success')
      redirect_to current_user, layout: 'admin'
    rescue ActiveRecord::RecordInvalid
      flash.now[:danger] = I18n.translate('post.submit.fail')
      render :new, layout: 'admin'
    end
  end

  def edit
    @post = Post.find(params[:id])
    render layout: 'admin'
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:success] = I18n.translate('post.update.success')
    redirect_to current_user, layout: 'admin'
  end

  def destroy
    Post.find(params[:id]).destroy!
    flash[:success] = I18n.translate('post.delete.success')
    redirect_to current_user, layout: 'admin'
  end

  private

  def post_params
    params.require('post').permit(:title, :body, :pro, :digest, :published)
  end

  private

  def check_admin
    unless current_user.admin?
      flash[:danger] = I18n.translate('post.not_authorized')
      redirect_to current_user
    end
  end
end