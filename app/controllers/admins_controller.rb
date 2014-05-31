class AdminsController < ApplicationController
	before_filter :check_signed_in, only: [:show]

	def show
		@admin = Admin.find(params[:id])
    render layout: 'admin'
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
