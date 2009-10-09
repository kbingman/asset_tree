namespace :radiant do
  namespace :extensions do
    namespace :asset_tree do
      
      desc "Runs the migration of the Asset Tree extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          AssetTreeExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          AssetTreeExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Asset Tree to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from FilesExtension"
        Dir[AssetTreeExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(AssetTreeExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
