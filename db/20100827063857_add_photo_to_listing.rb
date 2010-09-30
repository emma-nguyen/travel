class AddPhotoToListing < ActiveRecord::Migration
  def self.up
	add_column :listings, :photo_file_name, :string # Original filename
    add_column :listings, :photo_content_type, :string # Mime type
    add_column :listings, :photo_file_size, :integer # File size in bytes
  end

  def self.down
	remove_column :listings, :photo_file_name
    remove_column :listings, :photo_content_type
    remove_column :listings, :photo_file_size
  end
end
