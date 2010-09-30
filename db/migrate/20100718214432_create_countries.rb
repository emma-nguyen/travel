class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :options => 'charset=utf8' do |t|
	  t.string :name
	  t.float :latitude, :longtitude
      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
