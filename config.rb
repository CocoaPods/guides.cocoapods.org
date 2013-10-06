set :css_dir,           'stylesheets'
set :js_dir,            'javascripts'
set :images_dir,        'images'
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

set :markdown_engine, :redcarpet
set :markdown, {
  :fenced_code_blocks => true,
  :autolink           => true,
  :smartypants        => true
}

activate :automatic_image_sizes
activate :rouge_syntax

require "lib/navigation_helpers.rb"

helpers NavigationHelpers