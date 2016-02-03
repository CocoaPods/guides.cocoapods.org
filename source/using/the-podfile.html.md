---
title: The Podfile
description: Learn all about the Podfile, which is used to declare dependencies for your project.
order: 2
external links:
  - "Non-trivial Podfile in Artsy/Eigen": https://github.com/artsy/eigen/blob/master/Podfile
  - "Podfile for a Swift project in Artsy/Eidolon": https://github.com/artsy/eidolon/blob/master/Podfile
---

## What is a Podfile?

The Podfile is a specification that describes the dependencies of the
targets of one or more Xcode projects. The file should simply be named `Podfile`.
All the examples in the guides are based on CocoaPods version 1.0 and onwards.

> A Podfile can be very simple, this adds AFNetworking to a single target:

```ruby
target 'MyApp' do
  pod 'AFNetworking', '~> 3.0'
end
```

> An example of a more complex Podfile linking an app and it's test bundle:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!

target 'MyApp' do
  pod 'GoogleAnalytics', '~> 3.1'

  # Has it's own copy of OCMock
  # and has access to GoogleAnalytics via the app
  # that hosts the test target

  target 'MyAppTests' do
    inherit! :search_paths
    pod 'OCMock', '~> 2.0.1'
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
 ```

> If you want multiple targets to share the same pods, use an `abstract_target`.

```ruby
# There are no targets called "Shows" in any Xcode projects
abstract_target 'Shows' do
  pod 'ShowsKit'
  pod 'Fabric'

  # Has it's own copy of ShowsKit + ShowWebAuth
  target 'ShowsiOS' do
    pod 'ShowWebAuth'
  end

  # Has it's own copy of ShowsKit + ShowTVAuth
  target 'ShowsTV' do
    pod 'ShowTVAuth'
  end
end
```

There is implicit abstract target at the root of the Podfile, so you could write the above example as:

``` ruby
pod 'ShowsKit'
pod 'Fabric'

# Has it's own copy of ShowsKit + ShowWebAuth
target 'ShowsiOS' do
  pod 'ShowWebAuth'
end

# Has it's own copy of ShowsKit + ShowTVAuth
target 'ShowsTV' do
  pod 'ShowTVAuth'
end
```

### Migrating from 0.x to 1.0

We have a [blog post](http://blog.cocoapods.org/CocoaPods-1.0/) explaining the changes in depth.

### Specifying pod versions

> When starting out with a project it is likely that you will want to use the latest version of a Pod. If this is the case, simply omit the version requirements.

```ruby
pod 'SSZipArchive'
```

> Later on in the project you may want to freeze to a specific version of a Pod, in which case you can specify that version number.

```ruby
pod 'Objection', '0.9'
```

Besides no version, or a specific one, it is also possible to use logical operators:

* `'> 0.1'`    Any version higher than 0.1
* `'>= 0.1'`   Version 0.1 and any higher version
* `'< 0.1'`    Any version lower than 0.1
* `'<= 0.1'`   Version 0.1 and any lower version

In addition to the logic operators CocoaPods has an optimistic operator `~>`:

* `'~> 0.1.2'` Version 0.1.2 and the versions up to 0.2, not including 0.2 and higher
* `'~> 0.1'` Version 0.1 and the versions up to 1.0, not including 1.0 and higher
* `'~> 0'` Version 0 and higher, this is basically the same as not having it.

For more information, regarding versioning policy, see:

* [Semantic Versioning](http://semver.org)
* [RubyGems Versioning Policies](http://guides.rubygems.org/patterns/#semantic-versioning)
* There's a great video from Google about how this works: ["CocoaPods and the Case of the Squiggly Arrow (Route 85)"](https://www.youtube.com/watch?v=x4ARXyovvPc).

## Using the files from a folder local to the machine.

> If you would like to develop a Pod in tandem with its client
project you can use `:path`.

```ruby
pod 'AFNetworking', :path => '~/Documents/AFNetworking'
```

Using this option CocoaPods will assume the given folder to be the
root of the Pod and will link the files directly from there in the
Pods project. This means that your edits will persist between CocoaPods
installations. The referenced folder can be a checkout of your favourite SCM or
even a git submodule of the current repo.

<aside>Note that the `podspec` of the Pod file is expected to be in that the designated folder.</aside>

### From a podspec in the root of a library repo.

Sometimes you may want to use the bleeding edge version of a Pod, a
specific revision or your own fork. If this is the case, you can specify that with your
pod declaration.

> To use the `master` branch of the repo:

```ruby
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git'
````

> To use a different branch of the repo:

```ruby
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :branch => 'dev'
```

> To use a tag of the repo:

```ruby
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :tag => '0.7.0'
```

> Or specify a commit:

```ruby
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :commit => '082f8319af'
```

It is important to note, though, that this means that the version will
have to satisfy any other dependencies on the Pod by other Pods.

The `podspec` file is expected to be in the root of the repo, if this
library does not have a `podspec` file in its repo yet, you will have
to use one of the approaches outlined in the sections below.
