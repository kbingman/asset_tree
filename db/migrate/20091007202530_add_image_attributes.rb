class AddImageAttributes < ActiveRecord::Migration
  def self.up
    rename_column :assets, :name, :title
    add_column :assets, :filename, :string
    add_column :assets, :content_type, :string
    add_column :assets, :size, :integer
  end

  def self.down
    rename_column :assets, :title, :name
    remove_column :assets, :filename
    remove_column :assets, :content_type
    remove_column :assets, :size
  end
end
