class UserMailer < ActionMailer::Base

	def signup_notification(user)
		@subject = "Andrew's Hostel Signup Notification"
		@recipients = user.email
		@from = "andrew.hostel@gmail.com"
		@sent_on = Time.now
		@body["user"] = user
	end

	def reset_password(user)
		@subject = "Reset Password Request"
		@recipients = user.login
		@from = "andrew.hostel@gmail.com"
		@sent_on = Time.now
		@body["user"] = user
	end
end
