class Admin::AssetsController < Admin::ResourceController  
  
  before_filter :fetch_folder, :only => [:new, :edit, :create, :new, :remove]
    
  private
  
    def fetch_folder
      @folder = Folder.find params[:folder_id]
    end
    
    def continue_url(options)
      options[:redirect_to] || (params[:continue] ? {:action => 'edit', :id => model.id} : admin_folder_url(model.folder))
    end
                            
end
