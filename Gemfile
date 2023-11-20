source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

ruby '3.1.1'

gem 'middleman', '~> 4.4'

gem 'middleman-gh-pages', git: 'https://github.com/CocoaPods/middleman-gh-pages.git'
gem 'middleman-livereload'
gem 'middleman-sprockets'
gem 'middleman-syntax'

gem 'rake'
gem 'redcarpet', github: 'vmg/redcarpet', ref: 'cef9abbcc411d07fd1b8c80e348a80efde2db323'
gem 'sass'

gem 'slim', '~> 4.0'
gem 'yard'

gem 'tilt'

gem 'github-markup'
gem 'nokogiri'
gem 'pygments.rb'

gem 'concurrent-ruby'

# Use mini_racer instead of therubyracer for compatibility with newer Ruby
# https://github.com/rubyjs/therubyracer/issues/467
gem 'mini_racer'

gem 'webrick'

# https://github.com/middleman/middleman-syntax/issues/80
gem 'haml', '< 6.0'

gem 'cocoapods', '~> 1.0'

group :development do
  gem 'foreman'
end
