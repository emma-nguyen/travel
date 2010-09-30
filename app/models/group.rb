class Group < ActiveRecord::Base
	has_many :listings_groups, :class_name => "ListingsGroups"
	has_many :listings, :through => :listings_groups
end
