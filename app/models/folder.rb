class Folder < ActiveRecord::Base
  
  before_create :make_folder
  before_save :create_assets
  before_destroy :delete_folder
  
  validates_presence_of :name
  validates_presence_of :slug
  # validate_format_of :slug
  
  has_many :assets
  acts_as_tree :order => 'name'
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  def path
    File.join(RADIANT_ROOT,'public', clean_url(url))
  end
    
  def url
    parent? ? parent.child_url(self) : clean_url(slug)
  end
  
  def child_url(child)
    clean_url(url + '/' + child.slug)
  end
  
  def files
    Dir[File.join(self.path, '*')].find_all{|file| file if File.file?(file)}
  end
  
  def rename_folder(new_name)
    new_path = if parent?
      File.join(RADIANT_ROOT,'public', parent.url, new_name)
    else
      File.join(RADIANT_ROOT,'public', new_name)
    end
    new_path = clean_url(new_path)
    FileUtils.mv(path, new_path) unless new_path == path
  end
  
  def parent?
    !parent.nil?
  end
  
  private

    def make_folder
      FileUtils.mkdir_p(path) unless File.exists?(self.path)
    end
    
    def create_assets
      files.each do |file|
        asset = Asset.find_or_create_by_name(File.basename(file))
        asset.folder_id = self.id
        asset.save
      end
    end
    
    def delete_folder
      FileUtils.rm_rf(path)
    end
    
    def clean_url(url)
      "/#{ url.strip }".gsub(%r{//+}, '/')
    end


  
end
