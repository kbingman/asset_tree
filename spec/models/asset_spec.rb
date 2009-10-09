require File.dirname(__FILE__) + '/../spec_helper'

describe Asset do
  dataset :folders
  test_helper :validations
  
  before do
    @asset = Asset.new :file_file_name => "Test File", :folder_id => folder_id(:root)
  end
  
  it "should require a file_file_name" do
    @asset.file_file_name = nil
    @asset.should_not be_valid
    @asset.errors.on(:file_file_name).should_not be_empty
  end
  
  it "should require a folder id" do
    @asset.folder_id = nil
    @asset.should_not be_valid
    @asset.errors.on(:folder_id).should_not be_empty
  end
  
end
