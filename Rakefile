
# Bootstrap task
#-----------------------------------------------------------------------------#

desc "Initializes your working copy to run the specs"
task :bootstrap do
  title "Environment bootstrap"

  puts "Updating submodules"
  # This can take a long time, so showing output
  sh "git submodule update --init --recursive"

  puts "Installing gems"
  execute_command "bundle install"

  puts "Creating data dir"
  execute_command "mkdir -p docs_data"
end

begin

  require 'bundler/setup'

  # Run task
  #-----------------------------------------------------------------------------#

  desc "Runs the site locally"
  task :serve do
    title 'Running locally'
    sh "open http://0.0.0.0:4567"
    sh "bundle exec middleman server"
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
      require 'bundler'
      Bundler.with_clean_env do
        sh "bundle update cocoapods"
      end
    end
  end

  # Generate namespace
  #-----------------------------------------------------------------------------#

  # Generates the data YAML ready to be used by the Middleman.
  #
  namespace :generate do

    desc "Generates the data for the dsl."
    task :dsl => [:tags] do
      require 'doc'
      puts "\e[1;33mBuilding DSL Data\e[0m"

      dsls.each do |dsl|
        name = dsl[:name]
        title = dsl[:title]

        files = ["cocoapods-core/#{name.downcase}/dsl"] + Array(dsl[:extra_files])
        files = files.flat_map do |file|
          Gem.loaded_specs.each_value.flat_map do |spec|
            spec.matches_for_glob(file + '.*')
          end
        end
        generator = Pod::Doc::Generators::DSL.new(files)
        generator.name = name

        generator.output_file = "docs_data/#{title.downcase}.yaml"
        generator.save
      end
    end

    desc "Generates the data for the commands."
    task :commands => [:tags] do
      require 'doc'
      puts "\e[1;33mBuilding Commands Data\e[0m"
      libs = %w[cocoapods cocoapods-deintegrate cocoapods-search cocoapods-trunk cocoapods-try]
      lib_paths = libs.map { |w| Gem.loaded_specs[w].full_require_paths.first }
      files = lib_paths.map { |l| FileList[File.join(l, '*/command/**/*.rb')] }.flatten
      generator = Pod::Doc::Generators::Commands.new(files)
      generator.output_file = "docs_data/commands.yaml"
      generator.save
    end

    desc "Generates all the metadata necessary for the middleman."
    task :all => [:dsl, :commands]

    desc "Loads Custom YARD tags into the generators."
    task :tags do
      require 'yard'
      YARD::Tags::Library.define_tag("CocoaPods", :CocoaPods)
    end
  end

rescue LoadError, NameError => e
  $stderr.puts "\033[0;31m" \
    '[!] Some Rake tasks haven been disabled because the environment' \
    ' couldn’t be loaded. Be sure to run `rake bootstrap` first or use the ' \
    "VERBOSE environment variable to see errors.\e[0m"
  if ENV['VERBOSE']
    $stderr.puts e.message
    $stderr.puts e.backtrace
    $stderr.puts
  end
end

# Helpers
#-----------------------------------------------------------------------------#

$LOAD_PATH << File.expand_path('lib')

def dsls
  [
    { :name => "Podfile", :title => "podfile", :extra_files => %w[cocoapods/installer/installation_options] },
    { :name => "Specification", :title => "podspec" },
  ]
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
