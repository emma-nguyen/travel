class Listing < ActiveRecord::Base
	belongs_to :city
	has_many :reviews
	has_many :listings_groups, :class_name => "ListingsGroups"
	has_many :groups, :through => :listings_groups
	has_many :listings_contacts, :class_name => "ListingsContacts"
	has_many :contacts , :through => :listings_contacts
	
	acts_as_taggable
	
	ajaxful_rateable :stars => 5, :dimensions => [:user_rating]


	acts_as_mappable :lat_column_name => :latitude,
                   :lng_column_name => :longtitude

	has_attached_file :photo,
	:styles => {
			:thumb => "100x100#",
			:small => "150x150>"
	}
	
	
	def geocode_address
		res=Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{self.latitude},#{self.longtitude}"
		res.full_address
	end

	
end
