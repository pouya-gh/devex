class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = I18n.translate('sign_in.success')
      redirect_to user
    else
      flash.now[:danger] = I18n.translate('sign_in.fail')
      render :new
    end
  end
end