class CreateListingsGroups < ActiveRecord::Migration
  def self.up
    create_table :listings_groups do |t|
	  t.integer :group_id, :listing_id
      t.timestamps
    end
  end

  def self.down
    drop_table :listings_groups
  end
end
