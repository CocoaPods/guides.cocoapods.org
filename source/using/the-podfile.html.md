---
title: The Podfile
description: Learn all about the Podfile, which is used to declare dependencies for your project.
order: 2
---

## What is a Podfile?

 The Podfile is a specification that describes the dependencies of the
 targets of one or more Xcode projects. The Podfile always creates an
 implicit target, named `default`, which links to the _first target_ of the
 user project.

> A podfile can be very simple:

```ruby
pod 'AFNetworking', '~> 1.0'
```

> An example of a more complex podfile can be:

```ruby
platform :ios, '6.0'
inhibit_all_warnings!

xcodeproj 'MyProject'

pod 'ObjectiveSugar', '~> 0.5'

target :test do
    pod 'OCMock', '~> 2.0.1'
end

post_install do |installer|
    installer.project.targets.each do |target|
        puts target.name
    end
end
 ```

> If you want multiple targets, like adding tests, to share the same pods.

```ruby
platform :ios, '6.0' 

link_with 'MyApp', 'MyApp Tests'
pod 'AFNetworking', '~> 1.0'
pod 'Objection', '0.9'
```


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

In addition to the logic operators CocoaPods has an optimisic operator `~>`:

* `'~> 0.1.2'` Version 0.1.2 and the versions up to 0.2, not including 0.2 and higher
* `'~> 0.1'` Version 0.1 and the versions up to 1.0, not including 1.0 and higher
* `'~> 0'` Version 0 and higher, this is basically the same as not having it.

For more information, regarding versioning policy, see:

* [Semantic Versioning](http://semver.org)
* [RubyGems Versioning Policies](http://docs.rubygems.org/read/chapter/7)

Finally, instead of a version, you can specify the `:head` flag. This
will use the pod’s latest version spec version, but force the download
of the ‘bleeding edge’ version. Use this with caution, as the spec
might not be compatible with the source material anymore.

```ruby
pod 'Objection', :head
```

## Version Conflicts

Pods often depend on other pods. Conflicts arise when multiple pods depend on different versions of another. Or you may want to tie a dependent pod to a particular version. 

> The conflict error looks like this:

```shell
[!] Podfile tries to activate `GoogleAnalytics-iOS-SDK (= 2.0beta4)', but already activated version `3.0' by ARAnalytics/GoogleAnalytics (1.6).
```

> To fix this, you simply add the `GoogleAnalytics-iOS-SDK` pod line before `ARAnalytics` and specify the version:

```ruby
pod 'GoogleAnalytics-iOS-SDK', '2.0beta4'
pod 'ARAnalytics/GoogleAnalytics'
```

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

<aside>Note that the `podspec` of the Pod file is expected to be in that folder.</aside>

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

> Or specify a commit:

```ruby
pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :commit => '082f8319af'
```

It is important to note, though, that this means that the version will
have to satisfy any other dependencies on the Pod by other Pods.

The `podspec` file is expected to be in the root of the repo, if this
library does not have a `podspec` file in its repo yet, you will have
to use one of the approaches outlined in the sections below.
