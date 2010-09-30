
class ListingController < ApplicationController
	def index
		# for redirection after login/logout
		session[:controller] = "listing"
		session[:action] = "index"
		session[:id] = params[:id]
		
		
		@listing = Listing.find_by_id(params[:id])
		@city = City.find_by_id(@listing.city_id)
		@groups = @listing.groups
		
		@options = "<option value='-1' checked>Choose a group</option>"
		for group in Group.find(:all) do
			if !group.listings.include?(@listing)
			@options = @options + "<option value=#{group.id}>#{group.hook}</option>"
			end
		end
		
		
		#review
		@curr_review = nil
		@other_reviews = nil
		if session[:user_id] != nil
			@other_reviews = Review.find(:all, :conditions => ['listing_id = ? and user_id != ?', @listing.id, session[:user_id]])
			@curr_review = Review.find(:first, :conditions => ['listing_id = ? and user_id = ?', @listing.id, session[:user_id]])
		else
			@other_reviews = Review.find(:all, :conditions => ['listing_id = ?', @listing.id])
		
		end
		
		
		@address = @listing.geocode_address
		if @listing.address == nil or @listing.address == ""
			@listing.update_attribute(:address, @address)
		end
		
		#
		# Google map handling
		#
		@map = GMap.new("map")
		# Use the larger pan/zoom control but disable the map type
		# selector
		@map.control_init(:large_map => true,:map_type => false)
		# Center the map on specific coordinates and focus in fairly
		# closely
		@map.center_zoom_init([@listing.latitude,@listing.longtitude], 15)
		marker = GMarker.new([@listing.latitude,@listing.longtitude], :title => @address )
		@map.overlay_init(marker)
		
		#calculate page view
		@pageView = PageView.find(:first, :conditions => ['controller = ? and action = ?', "listing","index"])
		if @pageView == nil
			@pageView = PageView.create(:controller => "listing", :action => "index", :page_view => "1")
		else
			pv = @pageView.page_view + 1
			@pageView.update_attribute(:page_view,pv)
		end
	end
	
	
	def addGroup
		if request.post?
			group = Group.find_by_id(params[:group_list])
			@listing = Listing.find_by_id(params[:id])
			@listing.groups << group
			@listing.save
			
			@groups = @listing.groups
			
			@options = "<option value='-1' checked>Choose a group</option>"
			for group in Group.find(:all) do
				if !group.listings.include?(@listing)
				@options = @options + "<option value=#{group.id}>#{group.hook}</option>"
				end
			end
			
			render :update do |page|
				page.replace_html "group_div", :partial => "groups"
			end
		end
	end
	
	def addReview
		review = Review.find(:first, :conditions => ['user_id = ? and listing_id = ?', session[:user_id], params[:id]])
		
		render :update do |page|
			page['review_form'].show
			if review != nil
				page['review_content'].innerHTML = review.text
			end
		end
	end
	
	def addReviewSubmit
		if request.post? 
			r_hash = Hash.new
			r_hash['user_id'] = session[:user_id]
			r_hash['listing_id'] = params[:id]
			r_hash['text'] = params['review_content']
			review = Review.find(:first, :conditions => ['user_id = ? and listing_id = ?', r_hash['user_id'], r_hash['listing_id']])
			if params['review_content'].strip != ""
				if review != nil
					review.update_attributes(r_hash)
				else
					review = Review.create(r_hash)
				end
			else
				if review != nil
					review.destroy
				end
			end
		end
		
		@curr_review = nil
		@other_reviews = nil
		if session[:user_id] != nil
			@other_reviews = Review.find(:all, :conditions => ['listing_id = ? and user_id != ?', params[:id], session[:user_id]])
			@curr_review = Review.find(:first, :conditions => ['listing_id = ? and user_id = ?', params[:id], session[:user_id]])
		else
			@other_reviews = Review.find(:all, :conditions => ['listing_id = ?', @listing.id])
		
		end
		render :update do |page|
			page.replace_html "review_list", :partial => "review_list"
			page['review_form'].hide
			page.visual_effect :	 , "review_#{session[:user_id]}"
		end
	end
	def addTag
		@listing = Listing.find_by_id(params[:id])
		@listing.tag_list.add(params[:tag_list], :parse => true)
		@listing.save
		render :update do |page|
			page.replace_html 'tag_div', :partial => 'tags'
		end
	end
	
	def rate
		@listing = Listing.find(params[:id])
		@listing.rate(params[:stars], User.find_by_id(session[:user_id]),params[:dimension])
		render :update do |page|
			page.replace_html @listing.wrapper_dom_id(params), ratings_for(@listing, params.merge(:wrap => false))
			page.visual_effect :highlight, @listing.wrapper_dom_id(params)
		end
	end
#	def tag_cloud 
#		@tags = Listing.tag_counts # returns all the tags used end
#	end
end
