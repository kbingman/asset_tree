module UrlAdditions
    
  Paperclip.interpolates :no_original_style do |attachment, style|
    style ||= :original
    style == attachment.default_style ? nil : "_#{style}"
  end
  
  Paperclip.interpolates :folder_url do |attachment, style|
    folder = attachment.instance.folder
    folder.url
  end
  
end