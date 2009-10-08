module FoldersHelper
   
  # Maybe I will change folder to have titles... 
  def node_name
    %{<span class="title">#{ h(@current_node.name) }</span>}
  end
  
  # This is bad, but lets me steal the node_helper methods
  def homepage
    @homepage ||= Page.find_by_parent_id(nil)
  end
  
  def folder_expander(level)
    unless @current_node.children.empty? or level == 0
      image((expanded_folder ? "collapse" : "expand"),
            :class => "expander", :alt => 'toggle children',
            :title => '')
    else
      ""
    end
  end
  
  def expanded_folder_rows
    unless @expanded_folder_rows
      @expanded_folder_rows = case
      when rows = cookies[:expanded_folder_rows]
        rows.split(',').map { |x| Integer(x) rescue nil }.compact
      else
        []
      end

      if homepage and !@expanded_folder_rows.include?(homepage.id)
        @expanded_folder_rows << homepage.id
      end
    end
    @expanded_folder_rows
  end

  def expanded_folder
    show_all? || expanded_folder_rows.include?(@current_node.id)
  end
  
end
