class GroupController < ApplicationController
	def index
		# for redirection after login/logout
		session[:controller] = "listing"
		session[:action] = "index"
		session[:id] = params[:id]
		
		@group = Group.find_by_id(params[:id])
		@listings = @group.listings
		
		
		@options = "<option value='-1' checked>Choose a listing</option>"
		for listing in Listing.find(:all) do
			if !@listings.include?(listing)
			@options = @options + "<option value=#{listing.id}>#{listing.hook}</option>"
			end
		end
	end
	
	def addListing
		if request.post?
			@group = Group.find_by_id(params[:id])
			listing = Listing.find_by_id(params[:listing_list])
			@group.listings << listing
			@group.save
			@listings = @group.listings
			
			@options = "<option value='-1' checked>Choose a listing</option>"
			for listing in Listing.find(:all) do
				if !@listings.include?(listing)
					@options = @options + "<option value=#{listing.id}>#{listing.hook}</option>"
				end
			end
			render :update do |page|
				page.replace_html "content" , :partial => "content"
				page.visual_effect :highlight, "listing_#{params[:listing_list]}"
			end
		end
	end
	
end
