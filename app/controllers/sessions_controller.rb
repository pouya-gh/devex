class SessionsController < ApplicationController
  before_filter :check_signed_in, except: [:destroy]

  def new
    
  end

  def admin_new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user, params[:remember_me]
      flash[:success] = I18n.translate('sign_in.success')
      redirect_to params[:redirect_url] || user
    else
      flash.now[:danger] = I18n.translate('sign_in.fail')
      render :new
    end
  end

  def admin_create
    admin = Admin.find_by(email: params[:session][:email])
    if admin && admin.authenticate(params[:session][:password])
      admin_sign_in admin, params[:remember_me]
      flash[:success] = I18n.translate('sign_in.success')
      redirect_to params[:redirect_url] || admin
    else
      flash[:danger] = I18n.translate('sign_in.fail')
      redirect_to admin_sign_in_url
    end
  end

  def destroy
    sign_out
    redirect_to root_url(subdomain: false)
  end

  private

  def check_signed_in
    redirect_to current_user if signed_in?
  end
end
