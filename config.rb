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
  activate :minify_javascript
  activate :minify_css
  activate :relative_assets
end

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

activate :automatic_image_sizes
activate :syntax
activate :sprockets

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
      # Partials in Middleman 4 are always loaded within the 'source' folder. We have now added a symlink
      # of shared resources into it that points to the git submodule at the root of this repo.
      # See: https://middlemanapp.com/basics/upgrade-v4/
      combined << partial("shared/includes/#{source}",:locals => { :guides => true })
    end.join
  end

end

# Allow shared assets folder to not be in source, thereby not dragging in every asset
after_configuration do
  sprockets.append_path "shared/img"
  sprockets.append_path "shared/js"
  sprockets.append_path "shared/fonts"
  sprockets.append_path "shared/includes"
  sprockets.append_path "shared/sass"
end

navigation_data = {
  'dsl' => [
    { :name => "podfile", :title => "Podfile Syntax Reference" },
    { :name => "podspec", :title => "Podspec Syntax Reference" },
  ],
}

# Dynamic pages for documentation, Pod, command line

navigation_data['dsl'].each do |dsl|
  name = dsl[:name]
  title = dsl[:title]
  proxy "syntax/#{name}.html", "templates/dsl.html", {
    :locals => { :name => name, :guides_page_browser_title => title, :guides_page_title => title + " <span>v#{Pod::VERSION}</span>", :fullwidth => true },
    :ignore => true,
  }
end

proxy "terminal/commands.html", "templates/commands.html", {
  :locals => { :name => 'commands', :guides_page_title => "Command-line Reference", :fullwidth => true },
  :ignore => true,
}

data.store(:site, ["guides"])
