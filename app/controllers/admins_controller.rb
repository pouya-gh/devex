class AdminsController < ApplicationController
	before_filter :check_signed_in, only: [:show]

	def show
		@admin = Admin.find(params[:id])
    render layout: 'admin'
	end

  def request_token
  end

  def send_password_token
    if(admin = Admin.find_by_email(params[:email]))
      @link = newpass_admin_url(admin.auth_token)
      respond_to do |format|
        UserMailer.password_reset_url_email(admin, @link).deliver        
        format.html
      end
    else
      flash.now[:danger] = I18n.translate('register.fail')
      render :fail
    end
  end

  def new_password
    if (@admin = Admin.find_by_auth_token(params[:id]))
      @token = params[:id]
      respond_to do |format|
        format.html
      end
    else
      flash.now[:danger] = I18n.translate('password_reset.token_not_valid')
      render :fail
    end
  end

  def reset_password
    if(@admin = Admin.find_by_auth_token(params[:token])) 
      @admin.password = params[:admin][:password]
      @admin.password_confirmation = params[:admin][:password_confirmation]
      if @admin.save
        flash[:success] = I18n.translate('password_reset.success')
        sign_in @admin, "false"
        redirect_to root_url
      else
        flash.now[:danger] = I18n.translate('password_reset.fail')
        @token = @admin.auth_token
        render :new_password
      end
    else
      flash.now[:danger] = I18n.translate('password_reset.token_not_valid')
      render :fail
    end   
  end

	private

  def check_signed_in
    if signed_in? && current_user.admin?
    else
    	flash[:warning] = I18n.translate('authorization.required')
      redirect_to sign_in_path(redirect_url: request.original_url)
    end
  end
end
