class Asset < ActiveRecord::Base

  # is_attachment :recipes => { :thumb => [{ :thumbnail => { :size => '42x42', :crop => true } }] }
  has_attached_file :file, 
    :url => ":folder_url/:basename:no_original_style.:extension", 
    :path => ":rails_root/public:folder_url/:basename:no_original_style.:extension",
    :styles => { :thumb => "42x42#" }
  
  belongs_to :folder
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  # def url
  #   "#{self.folder.url}/#{self.name}"
  # end
  # 
  # def path
  #   File.join self.folder.path, self.name
  # end
  #   
end
