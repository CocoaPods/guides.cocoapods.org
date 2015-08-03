---
title: Using a Gemfile
description: Find out how you can use a Gemfile to version your ruby dependencies
order: 6
ignore: true

---

## RubyGems + Bundler

For many, CocoaPods is the first introduction to dependency management in programming projects. A lot of
ideas for CocoaPods came from similar projects ( for example [RubyGems](https://rubygems.org), [Bundler](http://bundler.io), [npm](https://www.npmjs.com) and [Gradle](http://gradle.org)). 

Understanding Ruby dependency management is useful because it allows you to specify versions of CocoaPods or other gems and ensure
all developers in your team have the exact same version. This guide is for people looking to ensure consistency in their team
dependencies or for using un-released versions of CocoaPods.

### RubyGems

RubyGems is a hosted ruby library service. It centralizes where you look for a library, and installing ruby libraries / apps. 
You'll have seen `gem install xxx`. These are installed into a central database of versions. If you imagine that CocoaPods
installs all libraries/frameworks into a System folder and they are linked at runtime, then you have the rough idea
of how RubyGems keeps all the gems.

The downside of this is that there is no way to ensure that a project needing a specific version of a library can use that, 
it would always use the latest version. So as a developer, you would be cautious installing a new version of a library
because it would be used in every library / app. This is the problem bundler solves.

### Bundler

Bundler creates a consistent application environment for your application, by allowing you to specify the version of libraries.
We took this idea almost whole-sale for CocoaPods. You define a Gemfile that says what libraries you want to include, and can 
optionally specify a version or range. You run `bundle install` and it will generate a Gemfile.lock saying the exact version of
all of your libraries and then anyone else running `bundle install` with that project gets the exact same versions.

### What is a Gemfile?

If you have read the guide on the [Podfile](/using/the-podfile.html), it will feel very similar. A Gemfile is a ruby file that defines your ruby
dependencies. Here is an [existing one](https://github.com/artsy/eigen/blob/2d9bfb8fba58e6ec0f2f3a18da7fbf45aaef6ba8/Gemfile) from a Cocoa project.

``` ruby
source 'https://rubygems.org'

gem 'cocoapods'
gem "cocoapods-keys"

gem 'fui', '~> 0.3.0'
gem 'xcpretty'
gem 'second_curtain', '~> 0.2.3'
gem 'fastlane'
```

All Gemfiles must include a source for their Gems, other than that you use the more or less the same syntax. 
This generates a [Gemfile.lock](https://github.com/artsy/eigen/blob/2d9bfb8fba58e6ec0f2f3a18da7fbf45aaef6ba8/Gemfile.lock) which in this case locks CocoaPods to version
[0.36.3](https://github.com/artsy/eigen/blob/2d9bfb8fba58e6ec0f2f3a18da7fbf45aaef6ba8/Gemfile.lock#L31).

### Using CocoaPods with a Gemfile

With a Gemfile setup, you run `bundle install` to install, or `bundle update` to update within your Gemfile's constraints.
From here on in however, you will need to remember to run `bundle exec` before any terminal commands that have come in via
bundler. Given that CocoaPods is included in the above this means any time you would write `pod XX YY` you need to do `bundle exec pod XX YY`.

Doing it without `bundle exec` will bypass your Gemfile's specific versioning and will use the latest version of the library within RubyGems. This
could potentially be the exact same version, but it can often not. If you are including CocoaPods plugins then they may also not be ran.

This means you can be sure that foundational tooling for projects are versioned just like your personal libraries.

### Using master CocoaPods

Often in-between releases you may be interested in using a Gemfile to work with an unreleased version of CocoaPods. Due to the size of the project
we try to release slowly when we're sure it won't break projects. Like with CocoaPods you can easily use master, or forks of your ruby project. Here is 
an [example of a Gemfile](https://github.com/artsy/eidolon/blob/3b1d28d9178a5790db3842c43513196e422ee0fb/Gemfile) using CocoaPods master.

``` ruby
source 'https://rubygems.org'

gem 'cocoapods', :git => 'https://github.com/CocoaPods/CocoaPods.git'
gem 'xcodeproj', :git => 'https://github.com/CocoaPods/Xcodeproj.git'

gem 'cocoapods-keys', :git => 'https://github.com/orta/cocoapods-keys.git'

gem 'xcpretty'
gem 'shenzhen'
gem 'sbconstants'
```

Running `bundle install` will get the versions from master. As CocoaPods is multiple gems, you may have to include [other dependencies](/contributing/components.html) like above.