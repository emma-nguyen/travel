class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities, :options => 'charset=utf8' do |t|
	  t.belongs_to :country
      t.string :name
	  t.float  :latitude, :longtitude
	  t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
