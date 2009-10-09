require_dependency 'application_controller'
require 'paperclip'
require File.dirname(__FILE__) + '/lib/files/url_additions'
include UrlAdditions

class FilesExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/files"

  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get, :import => :post } do |admin|
      admin.resources :folders do |folder|
        folder.resources :children, :controller => "folders"
        folder.resources :assets, :member => { :remove => :get }
      end
    end
  end
  
  def activate
    ApplicationController.class_eval do
      helper Admin::NodeHelper
      helper FoldersHelper
    end
    unless defined? admin.folder
      Radiant::AdminUI.send :include, Files::AdminUI  # UI is a singleton and already loaded
      admin.folder = Radiant::AdminUI.load_default_folder_regions
      admin.asset = Radiant::AdminUI.load_default_asset_regions
    end
    
    admin.nav << admin.nav_tab(:assets, "Assets")
    admin.nav[:assets] << admin.nav_item(:files, "Files", "/admin/folders")
  end
end
