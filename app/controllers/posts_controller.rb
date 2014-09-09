class PostsController < ApplicationController
  before_filter :check_admin, except: [:index, :show]
  before_filter :check_signed_in, only: [:index]

  def index
    @posts = if params[:tag]
      Post.has_tag(params[:tag])  
    elsif params[:q]
      Post.search_query(params[:q])
    else
      Post.find_by(published: true)
    end
    if current_user.admin?
      render :index, layout: 'admin'
    else
      render :index
    end
  end

  def new
    @post = current_user.posts.new
    # If I leave tags attribute to remain as an array
    # in the form instead of an empty for you would have
    # seen a "[]", which would have been akward!
    @post.tags = ""
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
      @post.tags = @post.tags.join(TAG_SEPARATOR)
      render :new, layout: 'admin'
    end
  end

  def show
    @post = Post.find_by(title: params[:id])
    if current_user.admin?
      render :show, layout: 'admin'
    end
    if @post.subscribtion_needed?
      unless signed_in?
        flash[:danger] = I18n.translate('post.not_authorized')
        redirect_to root_path
      end
    end
  end

  def edit
    @post = Post.find_by(title: params[:id])
    @post.tags = @post.tags.join(TAG_SEPARATOR)
    render layout: 'admin'
  end

  def update
    @post = Post.find_by(title: params[:id])
    @post.update(post_params)
    flash[:success] = I18n.translate('post.update.success')
    redirect_to current_user, layout: 'admin'
  end

  def destroy
    Post.find_by(title: params[:id]).destroy!
    flash[:success] = I18n.translate('post.delete.success')
    redirect_to current_user, layout: 'admin'
  end

  private

  def post_params
    temp = params.require('post').permit(:title, :body, :pro, :digest, :published, :tags)
    temp[:tags] = temp[:tags].split(TAG_SEPARATOR)
    temp 
  end

  private

  def check_admin
    unless current_user.admin?
      flash[:danger] = I18n.translate('post.not_authorized')
      redirect_to current_user
    end
  end

  def check_signed_in
    unless signed_in?
      flash[:warning] = I18n.translate('authorization.required')
      redirect_to sign_in_path(redirect_url: request.original_url)
    end
  end
end