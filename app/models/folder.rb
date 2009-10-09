class Folder < ActiveRecord::Base
  
  before_create :make_folder
  before_destroy :delete_folder
  
  validates_presence_of :name
  
  validates_presence_of :slug
  validates_format_of :slug, :with => %r{^([-_A-Za-z0-9]*|/)$}
  validates_uniqueness_of :slug, :scope => :parent_id
  
  has_many :assets, :dependent => :destroy
  acts_as_tree :order => 'name'
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  def path
    File.join(RAILS_ROOT,'public', clean_url(url))
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
      File.join(RAILS_ROOT,'public', parent.url, new_name)
    else
      File.join(RAILS_ROOT,'public', new_name)
    end
    new_path = clean_url(new_path)
    FileUtils.mkdir(path) unless File.exists?(path)
    FileUtils.mv(path, new_path) unless new_path == path
  end
  
  def import_assets
    files.each do |file|
      name = File.basename(file)
      unless asset = Asset.first(:conditions => { :folder_id => self.id, :file_file_name => name })
        Asset.create :folder_id => self.id, :file => File.open(file)
      end
    end
  end
  
  def parent?
    !parent.nil?
  end
  
  private

    def make_folder
      FileUtils.mkdir_p(path) unless File.exists?(self.path)
    end
    

    
    def delete_folder
      FileUtils.rm_rf(path)
    end
    
    def clean_url(url)
      "/#{ url.strip }".gsub(%r{//+}, '/')
    end


  
end
