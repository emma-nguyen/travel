class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => 'charset=utf8' do |t|
	  t.string :username, 
			   :email, 
			   :hashed_password, 
			   :activation_code,
			   :temp_pass,
			   :temp_pass_active
	  t.integer :active
			   
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
