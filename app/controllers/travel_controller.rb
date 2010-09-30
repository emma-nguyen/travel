class TravelController < ApplicationController
	def index
		session[:controller] = "travel"
		session[:action] = "index"
		@countries = Country.find(:all)
	end
	
	
	def city
		session[:controller] = "travel"
		session[:action] = "city"
		@city = City.find_by_id(params[:id])
		@listings = @city.listings
	end
	
	
	def getCities
		cities = City.find(:all, :conditions => ['country_id = ?', params[:country_id]])
		result = Array.new
		for city in cities do
			tmp = Array.new
			tmp << city.id
			tmp << city.name
			result <<	tmp
		end
		render :text => result.to_json
	end
	
	
end
