class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups, :options => 'charset=utf8' do |t|
	  t.string :name, :hook, :description
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
