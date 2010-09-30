class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings, :options => 'charset=utf8'  do |t|
	  t.belongs_to :city
	  t.string :name, :hook, :description, :address, :opening_hour
	  t.float  :longtitude, :latitude
      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
