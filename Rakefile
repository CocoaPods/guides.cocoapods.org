# Run task
#-----------------------------------------------------------------------------#

desc "Runs the site locally"
task :run do
  title 'Running locally'
  sh "open http://0.0.0.0:4567"
  sh "bundle exec middleman server"
end

# Bootstrap task
#-----------------------------------------------------------------------------#

desc "Initializes your working copy to run the specs"
task :bootstrap do
  title "Environment bootstrap"

  puts "Updating submodules"
  execute_command "git submodule update --init --recursive"

  puts "Installing gems"
  execute_command "bundle install"

  puts "Creating data dir"
  execute_command "mkdir -p docs_data"
end

# Deploy task
#-----------------------------------------------------------------------------#

begin
  require 'middleman-gh-pages'
  desc 'Build and push the guides to GitHub Pages'
  task :deploy => ['generate:all', :publish]
rescue LoadError
  $stderr.puts "[!] Disabled the middleman publish task, run `rake bootstrap` first."
end

# Gems namespace
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

# Generate namespace
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

    dsls.each do |dsl|
      name = dsl[:name]
      title = dsl[:title]

      dsl_file = (ROOT + "gems/Core/lib/cocoapods-core/#{name.downcase}/dsl.rb").to_s
      generator = Pod::Doc::Generators::DSL.new(dsl_file)
      generator.name = name

      generator.output_file = "docs_data/#{title.downcase}.yaml"
      generator.save
    end
  end

  desc "Generates the data for the commands."
  task :commands do
#    puts "\e[1;33mBuilding Commands Data\e[0m"
#    files = FileList[(ROOT + "gems/CocoaPods/lib/cocoapods/command/*.rb").to_s]
#    # These should probably not be in that directory.
#    files.exclude(/advanced_linter/)
#    files.exclude(/error_report/)
#    generator = Pod::Doc::Generators::Commands.new(files)
#    generator.output_file = "docs_data/commands.yaml"
#    generator.save
  end

  desc "Generates all the metadata necessary for the middleman"
  task :all => [:dsl, :gems, :commands]
  task :default => 'all'
end

# Helpers
#-----------------------------------------------------------------------------#

$LOAD_PATH << 'lib'

def dsls
  [ { :name => "Podfile", :title => "podfile" }, {:name => "Specification", :title => "podspec"} ]
end

def execute_command(command)
  if ENV['VERBOSE']
    sh(command)
  else
    output = `#{command} 2>&1`
    raise output unless $?.success?
  end
end

def title(title)
  cyan_title = "\033[0;36m#{title}\033[0m"
  puts
  puts "-" * 80
  puts cyan_title
  puts "-" * 80
  puts
end

