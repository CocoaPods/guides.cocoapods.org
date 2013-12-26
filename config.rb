# Layouts
require "lib/breaking_source.rb"
require "lib/add_links_to_navigation.rb"

# Tools for generating data
require "lib/navigation_helpers.rb"
require "lib/html_helpers.rb"
require 'lib/doc/code_objects'

set :encoding, 'utf-8'
set :relative_links, true

# Support for browsing from the build folder.
set :strip_index_file,  false

configure :build do
  activate :sprockets
  activate :minify_javascript
  activate :minify_css
  activate :relative_assets
end

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

activate :automatic_image_sizes
activate :rouge_syntax

activate :breaking_source
activate :add_links_to_navigation

helpers NavigationHelpers
helpers HTMLHelpers

configure :development do
  activate :livereload
end


helpers do
  
  def shared_partial(*sources)
    sources.inject([]) do |combined, source|
      combined << partial("../shared/includes/#{source}",:locals => { :guides => true })
    end.join
  end
  
end

# Allow shared assets folder to not be in source, thereby not dragging in every asset
after_configuration do
  sprockets.append_path "../shared/img"
  sprockets.append_path "../shared/js"
  sprockets.append_path "../shared/fonts"
  sprockets.append_path "../shared/includes"
  sprockets.append_path "../shared/sass"
end

navigation_data = {
  'dsl' => [ 
    { :name => "podfile", :title => "Podfile Syntax Reference" }, 
    {:name => "podspec", :title => "Podspec Syntax Reference"} 
  ],
  'gems' => %w[ CocoaPods CLAide cocoapods-downloader cocoapods-core Xcodeproj]
}

content_for :dsl_data do navigation_data * '<br>' end

# Dynamic pages for documentation, Pod, command line

navigation_data['dsl'].each do |dsl|
  name = dsl[:name]
  title = dsl[:title]
  proxy "syntax/#{name}.html", "templates/dsl.html", {
    :locals => { :name => name, :page_title => title, :fullwidth => true},
    :ignore => true
  }
end

proxy "terminal/commands.html", "templates/commands.html", {
  :locals => { :name => 'commands', :page_title => "Command-line Reference", :fullwidth => true  },
  :ignore => true
}

data.store("site", "guides")
# 
gems = []
navigation_data['gems'].each do |name|
  proxy "#{parameterize name}/index.html", "templates/gem.html", {
    :locals => { :name => name, :fullwidth => true },
    :ignore => true
  }

  proxy "#{parameterize name}/name_spaces.html", "templates/gem_namespaces_list.html", {
    :locals => { :name => name, :fullwidth => true },
    :ignore => true
  }

  proxy "#{parameterize name}/gem_todo_list.html", "templates/gem_todo_list.html", {
    :locals => { :name => name },
    :ignore => true
  }

  # FIXME
  gem = deserialize(name)
  gems << gem
  gem.name_spaces.each do |name_space|
    proxy "#{link_for_code_object(name_space)}/index.html", "templates/gem_namespace.html", {
      :locals => { :name_space => name_space, :code_object => name_space },
      :ignore => true
    }
  end
end
data.store('gems', gems)