class UserController < ApplicationController
	
	
	def login
		if request.post?
			session[:user_id] = nil
			user = User.authenticate(params[:user][:username], params[:user][:password])
			if user
				if user.active == 1
					session[:user_id] = user.id
				else
					flash[:notice] = "This account has not been activated. Please activate before log in."
				end
			else
				flash[:notice] = "Login failed"
			end
			
			if session[:user_id] == nil
				redirect_to :controller => "user" , :action => "login"
			else
				if session[:controller] == nil or session[:action] == nil
					redirect_to :controller => "travel", :action => "index"
				elsif session[:id] == nil
					redirect_to :controller => session[:controller], :action => session[:action]
				else
					redirect_to :controller => session[:controller], :action => session[:action], :id => session[:id]
				end
			end
		end
		
	end
	
	def logout
		session[:user_id] = nil
		redirect_to :controller => "user", :action => "login"
		
	end
	def register
		if request.post?
			
			if params[:user][:username] == ""
				flash[:username] = "Please specify your username."
			end
			
			if params[:user][:password] == ""
				flash[:password] = "Please specify your password."
			end

			if params[:user][:email] == ""
				flash[:email] = "Please specify your email."
			end
			if flash[:username] == nil and flash[:email] == nil and flash[:password] == nil
				@user = User.new(params[:user])
				@tmp = User.find_by_username(@user.username)
				if @tmp != nil
					flash[:username] = "Username already taken."
				else
					flash[:username] = nil
				end
				@tmp = User.find_by_email(@user.email)
				if @tmp != nil
					flash[:email] = "There is an existing account associated with this email address."
				else
					flash[:email] = nil
				end
			
				if params[:user][:password] != params[:user][:password_confirmation]
					flash[:password] = "Passwords do not match"
				else
					flash[:password] = nil
				end
			
				if flash[:username] == nil and flash[:email] == nil and flash[:password] == nil
					@user.activation_code = UserController.random_string(32)
					@user.save
					flash[:notice] = "Account registered. Please check your email for details on how to activate it."
				end
			end
		end
	end
	
	def activate
		
	end
	
	def self.random_string(len)
		chars = ("a".."z").to_a + ("0".."9").to_a
		result = ""
		1.upto(len){|i| result << chars[rand((chars.size) -1)]}
		result
	end
	
end
