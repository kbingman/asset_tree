class FoldersDataset < Dataset::Base
  
  def load
    create_record Asset, :file => 'test.jpg'
  end
  
end