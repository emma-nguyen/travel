require 'digest/md5'
class User < ActiveRecord::Base
	has_many :reviews
	has_many :contacts
	
	ajaxful_rater

	validates_presence_of :username
	validates_uniqueness_of :username
	
	attr_accessor :password_confirmation
	validates_confirmation_of :password
	
	def validate
		errors.add_to_base("Missing password") if hashed_password.blank?
	end
	
	def self.authenticate(username, password)
		user = self.find_by_username(username)
		if user
			expected_password = encrypted_password(password)
			if user.hashed_password != expected_password
				user = nil
			end
		end
		user
	end
	
	def password
		@password
	end
	
	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		self.hashed_password = User.encrypted_password(pwd)
	end
	
	private
	
	def self.encrypted_password(password)
		Digest::MD5.hexdigest(password)
	end
end
