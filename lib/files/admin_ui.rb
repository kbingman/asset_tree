module Files::AdminUI

 def self.included(base)
   base.class_eval do

      attr_accessor :folder, :asset
      alias_method :folders, :folder
      alias_method :assets, :asset
      
      protected

        def load_default_folder_regions
          returning OpenStruct.new do |folder|
            folder.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form}
              edit.form.concat %w{edit_title edit_extended_metadata edit_content edit_filter}
              edit.form_bottom.concat %w{edit_buttons edit_timestamp}
            end
            folder.show = Radiant::AdminUI::RegionSet.new do |show|
              show.top.concat %w{title}
              show.thead.concat %w{title_header modify_header}
              show.tbody.concat %w{title_cell modify_cell}
              show.bottom.concat %w{new_button}
            end
            folder.index = Radiant::AdminUI::RegionSet.new do |index|
              index.top.concat %w{help_text}
              index.thead.concat %w{title_header modify_header}
              index.node.concat %w{title_cell edit_cell add_child_cell remove_cell}
              index.bottom.concat %w{new_button}
            end
            folder.new = folder.edit
          end
        end
        
        def load_default_asset_regions
          returning OpenStruct.new do |asset|
            asset.edit = Radiant::AdminUI::RegionSet.new do |edit|
              edit.main.concat %w{edit_header edit_form}
              edit.form.concat %w{edit_title edit_content}
              edit.form_bottom.concat %w{edit_buttons edit_timestamp}
            end
            asset.new = asset.edit
          end
        end
      
    end
  end
end