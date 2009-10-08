class AddSlugToFolder < ActiveRecord::Migration
  def self.up
    add_column :folders, :slug, :string
  end

  def self.down
    remove_column :folders, :slug
  end
end
