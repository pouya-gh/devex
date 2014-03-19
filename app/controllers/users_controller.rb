class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    begin
      @user.save!
      flash[:success] = I18n.translate('register.success')
      redirect_to @user
    rescue ActiveRecord::RecordInvalid
      flash.now[:danger] = I18n.translate('register.fail')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end