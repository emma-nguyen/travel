class CreateUsersGroups < ActiveRecord::Migration
  def self.up
    create_table :users_groups do |t|
	  t.integer :user_id, :group_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users_groups
  end
end
