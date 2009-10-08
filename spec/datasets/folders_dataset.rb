class FoldersDataset < Dataset::Base
  
  def load
    create_record Folder, :root, :name => 'Root', :slug => 'root', :parent_id => nil
  end
  
end