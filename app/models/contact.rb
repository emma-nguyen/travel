class Contact < ActiveRecord::Base
	belongs_to :user
	has_many :listings_contacts, :class_name => "ListingsContacts"
	has_many :listings , :through => :listings_contacts
end
