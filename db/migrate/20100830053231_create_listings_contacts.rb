class CreateListingsContacts < ActiveRecord::Migration
  def self.up
    create_table :listings_contacts do |t|
	  t.integer :listing_id, :contact_id
      t.timestamps
    end
  end

  def self.down
    drop_table :listings_contacts
  end
end
