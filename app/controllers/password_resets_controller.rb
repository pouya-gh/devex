class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = Admin.find_by_email(params[:email]) ||
           User.find_by_email(params[:email])
    if user
      @link = edit_password_reset_url(id: user.auth_token)
      UserMailer.password_reset_url_email(user, @link).deliver
    else
      flash.now[:danger] = I18n.translate('register.fail')
      render :new
    end
  end

  def edit
    @user = Admin.find_by_auth_token(params[:id]) ||
            User.find_by_auth_token(params[:id])
    unless @user
      flash.now[:danger] = I18n.translate('password_reset.token_not_valid')
      render 'shared/fail'
    end
  end

  def update
    @user = Admin.find_by_auth_token(params[:token]) ||
           User.find_by_auth_token(params[:token])
    if !@user
      flash.now[:danger] = I18n.translate('password_reset.token_not_valid')
      render 'shared/fail'
    elsif @user.update(password_params)
      sign_in @user, false
      flash[:success] = I18n.translate('password_reset.success')
      redirect_to root_url
    else
      flash.now[:danger] = I18n.translate('password_reset.fail')
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def check_signed_in
    redirect_to current_user if signed_in?
  end
end
