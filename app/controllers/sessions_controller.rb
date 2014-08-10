class SessionsController < ApplicationController
  before_filter :check_signed_in, except: [:destroy]

  def new
    
  end

  def admin_new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    sign_in_person(user)
  end

  def admin_create
    admin = Admin.find_by(email: params[:session][:email])
    sign_in_person(admin)
  end

  def destroy
    sign_out
    redirect_to root_url(subdomain: false)
  end

  private

  def check_signed_in
    redirect_to current_user if signed_in?
  end

  def sign_in_person(user)
    if user && user.authenticate(params[:session][:password])
      sign_in user, params[:remember_me]
      flash[:success] = I18n.translate('sign_in.success')
      redirect_to params[:redirect_url] || user
    else
      flash[:danger] = I18n.translate('sign_in.fail')
      redirect_to params[:form_url]
    end
  end
end
