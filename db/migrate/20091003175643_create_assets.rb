class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :name
      t.integer :folder_id
      t.integer :created_by_id
      t.integer :updated_by_id
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
