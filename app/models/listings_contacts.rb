class ListingsContacts < ActiveRecord::Base
	belongs_to :contact
	belongs_to :listing
end
