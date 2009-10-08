require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::FoldersController do

  dataset :users, :folders

  before :each do
    login_as :existing
  end

  it "should route children to the folders controller" do
    route_for(:controller => "admin/folders", :folder_id => '1',
      :action => "index").should == '/admin/folders/1/children' 
    route_for(:controller => "admin/folders", :folder_id => '1',
      :action => 'new').should == '/admin/folders/1/children/new'
  end
  
  it "should be a ResourceController" do
    controller.should be_kind_of(Admin::ResourceController)
  end

  it "should handle Folders" do
    controller.class.model_class.should == Folder
  end
  
  describe "with invalid folder id" do
    [:edit, :remove].each do |action|
      before do
        @parameters = {:id => 999}
      end
      it "should redirect the #{action} action to the index action" do
        get action, @parameters
        response.should redirect_to(admin_folders_path)
      end
      it "should say that the 'Folder could not be found.' after the #{action} action" do
        get action, @parameters
        flash[:notice].should == 'Folder could not be found.'
      end
    end
    it 'should redirect the update action to the index action' do
      put :update, @parameters
      response.should redirect_to(admin_folders_path)
    end
    it "should say that the 'Folder could not be found.' after the update action" do
      put :update, @parameters
      flash[:notice].should == 'Folder could not be found.'
    end
    it 'should redirect the destroy action to the index action' do
      delete :destroy, @parameters
      response.should redirect_to(admin_folders_path)
    end
    it "should say that the 'Folder could not be found.' after the destroy action" do
      delete :destroy, @parameters
      flash[:notice].should == 'Folder could not be found.'
    end
  end

end
