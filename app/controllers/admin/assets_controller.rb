class Admin::AssetsController < Admin::ResourceController  
  
  before_filter :fetch_folder, :only => [:new, :edit]
    
  private
  
    def fetch_folder
      @folder = Folder.find params[:folder_id]
    end
                            
end
