---
title: Getting Started
description: This is a guide for setting up CocoaPods and working with your first project.
order: 0
external links:
-
  "CocoaPods at Treehouse": http://teamtreehouse.com/library/ios-tools/cocoapods/cocoapods
  "Streamlining Cocoa Development With CocoaPods": http://code.tutsplus.com/tutorials/streamlining-cocoa-development-with-cocoapods--mobile-15938
---

## What is CocoaPods

CocoaPods manages library dependencies for your Xcode projects.

The dependencies for your projects are specified in a single text file called a Podfile. CocoaPods will resolve dependencies between libraries, fetch the resulting source code, then link it together in an Xcode workspace to build your project.

Ultimately the goal is to improve discoverability of, and engagement in, third party open-source libraries by creating a more centralised ecosystem.

## Getting Started

### Installation

CocoaPods is built with Ruby and it will be installable with the default Ruby
available on OS X. You can use a Ruby Version manager, however we recommend that
you use the standard Ruby available on OS X unless you know what you're doing.

Using the default Ruby install will require you to use `sudo` when installing
gems. (This is only an issue for the duration of the gem installation, though.)

```shell
$ sudo gem install cocoapods
```

_During this process RubyGems might ask you if you want to overwrite the `rake`
executable. This warning is raised because the `rake` gem will be updated as
part of this process. Simply confirm by typing `y`._

If you do *not* want to grant RubyGems admin privileges for this process, you can
tell RubyGems to install into your user directory by passing either the
`--user-install` flag to `gem install` or by configuring the RubyGems environment.
The latter is in our opinion the best solution. To do this, create or edit the
`.profile` file in your home directory and add or amend it to include these lines:

```shell
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH
```

Note that if you choose to use the `--user-install` option, you will still have
to configure your `.profile` file to set the `PATH` or use the command prepended by
the full path. You can find out where a gem is installed with `gem which
cocoapods`. E.g.

```shell
$ gem install cocoapods --user-install
$ gem which cocoapods
/Users/eloy/.gem/ruby/2.0.0/gems/cocoapods-0.29.0/lib/cocoapods.rb
$ /Users/eloy/.gem/ruby/2.0.0/bin/pod install
```

### Updating CocoaPods

> To update CocoaPods you simply install the gem again

```shell
$ [sudo] gem install cocoapods
```

> Or for a pre-release version

```shell
$ [sudo] gem install cocoapods --pre
```

If you originally installed the cocoapods gem using `sudo`, you should use that command again.

Later on, when you're actively using CocoaPods by installing pods, you will be notified when new versions become available with a *CocoaPods X.X.X is now available, please update* message.


[creating-a-workspace]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#creating_a_workspace
[adding-projects-to-workspace]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#adding_projects_to_a_workspace
[configuring-project-scheme]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#configuring_the_projects_scheme
[adding-build-target-dependencies]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#adding_build_target_dependencies
[basing-target-configurations-on-xcconfig]: http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Conceptual/Xcode4UserGuide/025-Configure_Your_Project/configure_project.html
