---
title: Getting Started
description: This is a guide for setting up CocoaPods and working with your first project.
order: 0
---

## What is CocoaPods

CocoaPods manages library dependencies for your Xcode projects.

The dependencies for your projects are specified in a single text file called Podspecs. CocoaPods will resolve dependencies between libraries, fetch the resulting source code, then link it together in an Xcode workspace to build your project.

Ultimately the goal is to improve discoverability of, and engagement in, third party open-source libraries by creating a more centralized ecosystem.

## Getting Started

### Dependencies

- Ruby MRI 2.0.0 or 1.8.7 (ships with Mac OS X)
- Xcode command line tools.

### Installation

CocoaPods is built with Ruby. For the best experience, we suggest installing a Ruby Version manager, like [RVM](http://rvm.io), and running Ruby 1.9.3 or newer. 

> When using RVM, or a similar tool, to install CocoaPods run

```shell
$ gem install cocoapods
```

> If you are using the bundled ruby from Apple, you need to prefix the command with sudo

```shell
$ sudo gem install cocoapods
```


### Updating CocoaPods

> To update CocoaPods you simply update the gem.

```shell
$ [sudo] gem update cocoapods
```

> Or for a pre-release version

```shell
$ [sudo] gem update cocoapods --pre
```

If you installed the gem using `sudo` you should use that command as well.


[creating-a-workspace]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#creating_a_workspace
[adding-projects-to-workspace]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#adding_projects_to_a_workspace
[configuring-project-scheme]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#configuring_the_projects_scheme
[adding-build-target-dependencies]: http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/#adding_build_target_dependencies
[basing-target-configurations-on-xcconfig]: http://developer.apple.com/library/ios/#documentation/ToolsLanguages/Conceptual/Xcode4UserGuide/025-Configure_Your_Project/configure_project.html
