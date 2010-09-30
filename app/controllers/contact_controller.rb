class ContactController < ApplicationController
	def index
		@user = User.find_by_id(session[:user_id])
		@contacts = @user.contacts
	end
	
	def createContact
		if request.post?
			contact = Contact.find(:first, :conditions => ['user_id = ? and name = ?', session[:user_id], params[:contact]])
			if contact == nil
				contact_hash = Hash.new
				contact_hash['user_id'] = session[:user_id]
				contact_hash['name'] = params[:contact]
				contact = Contact.create(contact_hash)
				
				render :update do |page|
					page.replace_html "content", :partial => "content"
					page.replace_html "spinner", "New contact created"
					page['spinner'].show
					page.visual_effect(:fade,"spinner", :duration => 2)
					page.visual_effect :highlight, "contact_#{contact.id}"
				end
			else
				render :update do |page|
					page.replace_html "spinner", "There is a contact list with the same name"
					page['spinner'].show
					page.visual_effect(:fade,"spinner", :duration => 2)
					
				end
			end
			
		end
	end
	
	def addListing
		if request.post? and params[:listing_list] != "-1"
			contact = Contact.find_by_id(params[:id])
			listing = Listing.find_by_id(params[:listing_list])
			contact.listings << listing
			contact.save
			
		end
	end
end
