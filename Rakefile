require 'middleman-gh-pages'

task :deploy do
  Rake::Task["publish"].invoke
end

#-----------------------------------------------------------------------------#

namespace :gems do

  desc "Checks out the latest tag available for each gem."
  task :update do
    Dir.glob('gems/*').each do |dir|
      Dir.chdir(dir) do
        puts "\e[1;33mUpdating #{dir}\e[0m"
        sh "git fetch"
        tag = `git for-each-ref --sort='*authordate' --format='%(refname:short)' refs/tags`.split("\n").last
        sh "git checkout #{tag}"
      end
    end
  end
end

#-----------------------------------------------------------------------------#

def gems
  %w[ CocoaPods CocoaPods-Core Xcodeproj CLAide cocoapods-downloader ]
end

def dsls
  %w[ Specification Podfile ]
end

#-----------------------------------------------------------------------------#

# Generates the data YAML ready to be used by the Middleman.
#
namespace :generate do
  require 'pathname'
  ROOT = Pathname.new(File.expand_path('../', __FILE__))
  $:.unshift((ROOT + 'lib').to_s)
  require 'doc'

  desc "Generates the data for the dsl."
  task :dsl do
    puts "\e[1;33mBuilding DSL Data\e[0m"

    dsls.each do |name|
      dsl_file = (ROOT + "gems/Core/lib/cocoapods-core/#{name.downcase}/dsl.rb").to_s
      generator = Pod::Doc::Generators::DSL.new(dsl_file)
      generator.name = name
      p dsl_file
      generator.output_file = "docs_data/#{name.downcase}.yaml"
      generator.save
    end
  end

  desc "Generates the data for the gems."
  task :gems do
    puts "\e[1;33mBuilding Gems Data\e[0m"

    gems.each do |name|
      github_name = name == 'CocoaPods-Core' ? 'Core' : name
      generator = Pod::Doc::Generators::Gem.new(ROOT + "gems/#{github_name}/#{name}.gemspec")
      generator.name = name
      generator.github_name = github_name
      generator.output_file = "docs_data/#{name.downcase.gsub('-','_')}.yaml"
      generator.save
    end
  end

  desc "Generates the data for the commands."
  task :commands do
    puts "\e[1;33mBuilding Commands Data\e[0m"
    files = FileList[(ROOT + "gems/CocoaPods/lib/cocoapods/command/*.rb").to_s]
    # These should probably not be in that directory.
    files.exclude(/advanced_linter/)
    files.exclude(/error_report/)
    generator = Pod::Doc::Generators::Commands.new(files)
    generator.output_file = "docs_data/commands.yaml"
    generator.save
  end

  # TODO To generate reliable urls, they should be considered part of the
  # model, an it should be computed by the code objects.
  #
  desc "Generates the data for the search."
  task :search do
    puts "\e[1;33mBuilding Search Data\e[0m"

    # [Hash{String=>Hash{String=>String}]
    result = {
      'dsls'        => {},
      'name_spaces' => {},
      'methods'     => {},
    }

    # FIXME DSL should have urls similar to the gems
    #
    dsls.each do |name|
      name = name.downcase.gsub('-','_')
      file = "docs_data/#{name}.yaml"
      dsl  = YAML::load(File.open(file))
      dsl.meths.compact.each do |method|
        result['dsls']["#{name}/#{method.name.downcase}"] = "#{name}.html##{method.name.downcase}"
      end
    end

    gems.each do |name|
      name = name.downcase.gsub('-','_')
      file = "docs_data/#{name}.yaml"
      gem  = YAML::load(File.open(file))
      gem.name_spaces.each do |ns|
        result['name_spaces'][ns.ruby_path] = "#{name}/#{ns.ruby_path.downcase.gsub(/::/,'/')}"
        ns.meths.compact.each do |method|
          result['methods'][method.ruby_path] = "#{name}/#{method.ruby_path.downcase.gsub(/::/,'/')}"
        end
      end
    end

    require 'json'
    File.open('source/typeahead.json', 'w') { |f| f.puts(result.to_json) }
  end

  desc "Generates all the metadata necessary for the middleman"
  task :all => [:dsl, :gems, :commands, :search]
  task :default => 'all'
end