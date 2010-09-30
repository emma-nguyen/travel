class CreatePageViews < ActiveRecord::Migration
  def self.up
    create_table :page_views do |t|
	  t.string :controller, :action
	  t.integer :page_view
      t.timestamps
    end
  end

  def self.down
    drop_table :page_views
  end
end
