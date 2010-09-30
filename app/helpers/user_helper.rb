module UserHelper
	def current_user
		if session[:user_id] != nil
			user = User.find_by_id(session[:user_id])
		end
		user
		
	end
end
