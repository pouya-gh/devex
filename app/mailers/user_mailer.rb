class UserMailer < ActionMailer::Base
  default from: "from@example.com"
	
	def password_reset_url_email(user, resetting_url)
	end

end
