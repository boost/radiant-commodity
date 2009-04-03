namespace :radiant do
  namespace :extensions do
    namespace :snippet_export do
      
      desc "Runs the migration of the Snippet Export extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          SnippetExportExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          SnippetExportExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Snippet Export to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from SnippetExportExtension"
        Dir[SnippetExportExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(SnippetExportExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
