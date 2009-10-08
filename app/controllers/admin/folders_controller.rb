class Admin::FoldersController < Admin::ResourceController   
  
  responses do |r|
    r.plural.js do
      @level = params[:level].to_i
      @template_name = 'index'
      response.headers['Content-Type'] = 'text/html;charset=utf-8'
      render :action => 'children.html.haml', :layout => false
    end
  end
  
  def index
    @root = Folder.find_by_parent_id(nil)
    response_for :plural
  end
  
  def show
    @folder = Folder.find params[:id]
    response_for :singular
  end      
  
  def update
    model.rename_folder(params[model_symbol][:slug])
    model.update_attributes!(params[model_symbol])
    response_for :update               
  end         
  
  private
    def model_class
      if params[:folder_id]
        Folder.find(params[:folder_id]).children
      else
        Folder
      end
    end

    def count_deleted_pages
      @count = model.children.count + 1
    end                                    
end
