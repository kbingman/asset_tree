class CreateFolders < ActiveRecord::Migration
  def self.up
    create_table :folders do |t|
      t.string :name
      t.integer :parent_id
      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :folders
  end
end
