---
title: Using Unreleased Features
description: Instructions to use CocoaPods from a feature branch or a Work-in-progress fork
ignore: true
--- 
## Using Unreleased Features

There may be times when you may want to test an upcoming feature in CocoaPods. At times code for such features may be already available in a 'feature branch'. Here is what you need to do to start using unreleased features in your project:

##### Create a [Gemfile](http://bundler.io/gemfile.html)  
Inside your project folder, where you normally create a Podfile, create a new file and call it 'Gemfile'. Your Gemfile should look like this:
```ruby
source 'https://rubygems.org'

gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :branch => 'swift'
gem 'cocoapods-core', :git => 'https://github.com/CocoaPods/Core.git'
gem 'xcodeproj',  :git => 'https://github.com/CocoaPods/Xcodeproj.git'
gem 'claide', :git => 'https://github.com/CocoaPods/CLAide.git'
gem 'cocoapods-downloader', :git => 'https://github.com/CocoaPods/cocoapods-downloader.git'
```  
If you intend to use 'master' branch for any component, then you can just write something like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git'
```

If you want to use a branch containing desired feature or bug-fix, which hasn't yet been merged to master then you can mention 'branch name' like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :branch => 'swift'
```
At times a contributor may still be working inside his/her personal repo (forked from official repo) on the feature before pushing it to the CocoaPods official repo, you can use his/her repo directly like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/mrackwitz/CocoaPods.git', :branch => 'swift'
```  

You can even [specify](http://bundler.io/git.html) a tag or commit for the repository. 

##### Install the unreleased copy of CocoaPods  
Run `$ bundle install`
##### Use unreleased copy of CocoaPods
Run `$ bundle exec pod install`  

`bundle exec` will ensure that you are using unreleased copy of CocoaPods you just installed (instead of using the system-wide official copy that you probably installed with `gem install cocoapods` previously some day). You can open the `xcworkspace` file to use and build the project from now on.

Likewise, for any other pod command that you want to run, precede it with `bundle exec` (`bundle exec pod update`, `bundle exec pod lib lint`, etc…) to ensure that you use the the unreleased version for this command, instead of the official version.
