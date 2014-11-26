---
title: Using Unreleased Features
description: Instructions to use CocoaPods from a feature branch or a Work-in-progress fork
ignore: true
--- 
## Using Unreleased Features

There may be times when you may want to test an upcoming feature in CocoaPods. At times code for such features may be already available in a 'feature branch'. Here is what you need to do to start using unreleased features in your project:

* Create a [Gemfile](http://bundler.io/gemfile.html)  

Inside your project folder, where you normally create a Podfile, create a new file and call it 'Gemfile'. Your Gemfile should look like this:
```ruby
source 'https://rubygems.org'

gem 'cocoapods', :git => [GIT LOCATION]
gem 'cocoapods-core', :git => [GIT LOCATION]
gem 'xcodeproj',  :git => [GIT LOCATION]
gem 'claide', :git => [GIT LOCATION]
gem 'cocoapods-downloader', :git => [GIT LOCATION]
```  
[GIT LOCATION] should point to Git source you want to use. If you intend to use 'master' branch for any component, then you can just write something like this:

```ruby
gem 'claide', :git => 'https://github.com/CocoaPods/CLAide.git'
```

If you want to use a branch containing desired feature or bug-fix, which hasn't yet been merged to master then you can mention 'branch name' in [GIT LOCATION] like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :branch => 'swift'
```
At times a contributor may still be working inside his/her personal repo (forked from official repo) on the feature before pushing it to the Cocoapods official repo, you can use his/her repo directly like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/mrackwitz/CocoaPods.git', :branch => 'swift'
```  

You can even [specify](http://bundler.io/git.html) a tag or commit for the repository as [GIT LOCATION]. 

* Run `$ bundle install` to install unreleased copy of Cocoapods 
* Run `$ bundle exec pod install` to setup your workspace. `bundle exec` will ensure that you are using unreleased copy of Cocoapods you just installed

That's it.
