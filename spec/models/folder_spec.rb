require File.dirname(__FILE__) + '/../spec_helper'

describe Folder do
  dataset :folders
  test_helper :validations
  
  before do
    @folder = Folder.new :name => "Test Folder", :slug => "test-folder", :parent_id => folder_id(:root)
  end
  
  it "should require a name" do
    @folder.name = nil
    @folder.should_not be_valid
    @folder.errors.on(:name).should_not be_empty
  end
  
  it "should require a slug" do
    @folder.slug = nil
    @folder.should_not be_valid
    @folder.errors.on(:slug).should_not be_empty
  end
  
  it "should not assign root a parent" do
    @folder = folders(:root)
    @folder.parent?.should == false
  end
  
  it "should assign a folder a parent" do
    @folder.parent?.should == true
  end
  
  it "should generate a url for the root folder" do
    @folder = folders(:root)
    @folder.url.should == "/root"
  end
  
  it "should generate a url for a normal folder" do
    @folder.url.should == "/root/test-folder"
  end
  
  it "should generate a path for the root folder" do
    @folder = folders(:root)
    @folder.path.should == "#{RAILS_ROOT}/public/root"
  end
  
  it "should generate a path for a normal folder" do
    @folder.path.should == "#{RAILS_ROOT}/public/root/test-folder"
  end
  
end
