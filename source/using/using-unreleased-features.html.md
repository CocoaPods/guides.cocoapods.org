---
title: Using Unreleased Features
description: Instructions to use CocoaPods from a feature branch or a Work-in-progress fork
ignore: true

external links:
-
  "Gemfile Configuration": http://bundler.io/gemfile.html
  "Getting Gems from git": http://bundler.io/git.html
  "CocoaPods Is Ready for Swift": http://swiftwala.com/cocoapods-is-ready-for-swift/
--- 
## Using Unreleased Features

There may be times when you may want to test an upcoming feature in CocoaPods. At times code for such features may be already available in a 'feature branch'. Here is what you need to do to start using unreleased features in your project:

#### Create a Gemfile 

Inside your project folder, where you normally create a `Podfile`, create a new file and call it `Gemfile`. Your `Gemfile` should look like this:
```ruby
source 'https://rubygems.org'

gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :branch => 'swift'
gem 'cocoapods-core', :git => 'https://github.com/CocoaPods/Core.git'
gem 'xcodeproj',  :git => 'https://github.com/CocoaPods/Xcodeproj.git'
gem 'claide', :git => 'https://github.com/CocoaPods/CLAide.git'
gem 'cocoapods-downloader', :git => 'https://github.com/CocoaPods/cocoapods-downloader.git'
```  
#### Choose correct Branch and Revision 

Please remember that you need to use compatible versions of each component in the `Gemfile`. This can be done by looking at the `Gemfile.lock` from the relevant branch of `CocoaPods`. For 'swift' branch of `CocoaPods`, `Gemfile.lock` at `https://github.com/CocoaPods/CocoaPods/blob/swift/Gemfile.lock` contains:

``` ruby
GIT
  remote: https://github.com/CocoaPods/Core.git
  revision: 8bfbc96858947f4db6dd1f4a3ea085b446ad35d3
  branch: master
```  
Which means for `cocoapods-core` gem we need to use `master` branch with revision `8bfbc96858947f4db6dd1f4a3ea085b446ad35d3` which can be done like this:

```ruby
gem 'cocoapods-core', :git => 'https://github.com/CocoaPods/Core.git' :ref => '8bfbc96858947f4db6dd1f4a3ea085b446ad35d3'
```
You need to check the `Gemfile.lock` for all the components and use correct git path.

If you want to use a branch containing desired feature or bug-fix, which hasn't yet been merged to `master` then you can mention 'branch name' like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git', :branch => 'swift'
```
At times a contributor may still be working inside his/her personal fork on the feature before pushing it to the CocoaPods official repo, you can use his/her forked repo directly like this:

```ruby
gem 'cocoapods', :git => 'https://github.com/mrackwitz/CocoaPods.git', :branch => 'swift'
```  

#### Install the unreleased copy of CocoaPods  

Run `$ bundle install`

#### Use unreleased copy of CocoaPods  

Run `$ bundle exec pod install`  

`bundle exec` will ensure that you are using unreleased copy of CocoaPods you just installed (instead of using the system-wide official copy that you probably installed with `gem install cocoapods` previously some day). You can open the `xcworkspace` file to use and build the project from now on.

Likewise, for any other pod command that you want to run, precede it with `bundle exec` (`bundle exec pod update`, `bundle exec pod lib lint`, etc…) to ensure that you use the the unreleased version for this command, instead of the official version.
