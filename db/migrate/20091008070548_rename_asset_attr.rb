class RenameAssetAttr < ActiveRecord::Migration
  def self.up
    rename_column :assets, :filename, :file_file_name
    rename_column :assets, :content_type, :file_content_type
    rename_column :assets, :size, :file_size
  end

  def self.down
    rename_column :assets, :file_file_name, :filename
    rename_column :assets, :file_content_type, :content_type
    rename_column :assets, :file_size, :size
  end
end
