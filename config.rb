require "lib/breaking_source.rb"
require "lib/breaking_image.rb"

set :encoding,          'utf-8'
set :relative_links,    true

# Support for browsing from the build folder.
set :strip_index_file,  false

configure :build do
  activate :sprockets
  activate :minify_javascript
  activate :minify_css
  activate :relative_assets
  activate :asset_hash
end

set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

configure :development do
  set :debug_assets, true
end

require "lib/navigation_helpers.rb"

activate :automatic_image_sizes
activate :rouge_syntax

activate :breaking_image
activate :breaking_source

helpers NavigationHelpers

after_configuration do
  sprockets.append_path "../shared/img"
  sprockets.append_path "../shared/fonts"
  sprockets.append_path "../shared/js"
  sprockets.append_path "../shared/includes"
  sprockets.append_path "../shared/sass"

end

after_build do
  puts "OK"
end
