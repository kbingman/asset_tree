class Asset < ActiveRecord::Base
  
  before_save :add_title
  
  @@image_content_types = ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']

  has_attached_file :file, 
    :url => ":folder_url/:no_original_style:basename.:extension", 
    :path => ":rails_root/public:folder_url/:no_original_style:basename.:extension",
    :styles => { :icon => "25x31#" }
  
  belongs_to :folder
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  validates_attachment_presence
  validates_uniqueness_of :file_file_name, :scope => :folder_id
  
  def url
    self.file.url
  end
  
  def filename
    self.file_file_name
  end
  
  def image?
    @@image_content_types.include?(self.file_content_type)
  end
  
  def thumbnail
    image? ? self.file.url(:icon) : '/images/admin/page.png'
  end
  
  def basename
    File.basename(self.file_file_name,'.*')
  end
    
  private
    
    def add_title
      self.title = self.basename if self.title.nil? || self.title.blank?
    end
end
