class UserMailer < ActionMailer::Base
  default from: "from@example.com"
	
	def password_reset_url_email(user, resetting_url)
		 @user = user
		 @resetting_url = resetting_url
		 mail(to: @user.email, subject: "Your password reset URL")
	end

end
