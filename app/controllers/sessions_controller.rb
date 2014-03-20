class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = I18n.translate('sign_in.success')
      redirect_to params[:redirect_url] || user
    else
      flash.now[:danger] = I18n.translate('sign_in.fail')
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end