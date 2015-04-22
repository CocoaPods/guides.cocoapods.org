---
title: Using CocoaPods
description: Integration instructions and best practices.
order: 1
---

## Adding Pods to an Xcode project

#### Before you begin

1. Check the [Specs](https://github.com/CocoaPods/Specs) repository or [cocoapods.org](https://cocoapods.org) to make sure the libraries you would like to use are available.
2. [Install CocoaPods](/using/getting-started.html#toc_3) on your computer.

### Installation

* Create a [Podfile](/using/the-podfile.html), and add your dependencies:

```ruby
pod 'AFNetworking', '~> 2.0'  
pod 'ObjectiveSugar', '~> 0.5'
```

* Run `$ pod install` in your project directory.
* Open `App.xcworkspace` and build.

###Creating a new Xcode project with CocoaPods

To create a new project with CocoaPods, follow these simple steps:

* Create a new project in Xcode as you would normally.
* Open a terminal window, and `$ cd` into your project directory.
* Create a Podfile. This can be done by running `$ touch Podfile`.
* Open your Podfile. The first line should specify the platform and version supported.

```ruby
platform :ios, '6.0'
````

* Add a CocoaPod by specifying `pod '$PODNAME'` on a single line

```ruby
pod 'ObjectiveSugar'
```
* Save your Podfile.
* Run `$ pod install`
* Open the `MyApp.xcworkspace` that was created. This should be the file you use everyday to create your app.

### Integration with an existing workspace

Integrating CocoaPods with an existing workspace requires one extra line in your Podfile. Simply specify the `.xcworkspace` root filename like so:

```ruby
workspace 'MyWorkspace'
```

## Should I check the Pods directory into source control?

Whether or not you check in your `Pods` folder is up to you, as workflows vary from project to project. We recommend that you keep the Pods directory under source control, and don't add it to your `.gitignore`. But ultimately this decision is up to you:

### Benefits of checking in the Pods directory

- After cloning the repo, the project can immediately build and run, even without having CocoaPods installed on the machine. There is no need to run `pod install`, and no Internet connection is necessary.
- The Pod artifacts (code/libraries) are always available, even if the source of a Pod (e.g. GitHub) were to go down.
- The Pod artifacts are guaranteed to be identical to those in the original installation after cloning the repo.

### Benefits of ignoring the Pods directory

- The source control repo will be smaller and take up less space.
- As long as the sources (e.g. GitHub) for all Pods are available, CocoaPods is generally able to recreate the same installation. (Technically there is no guarantee that running `pod install` will fetch and recreate identical artifacts when not using a commit SHA in the Podfile. This is especially true when using zip files in the Podfile.)
- There won't be any conflicts to deal with when performing source control operations, such as merging branches with different Pod versions.

Whether or not you check in the `Pods` directory, the `Podfile` and `Podfile.lock` should always be kept under version control.

## What is `Podfile.lock`?

This file is generated after the first run of `pod install`, and tracks the version of each Pod that was installed. For example, imagine the following dependency specified in the Podfile:

```ruby
pod 'RestKit'
```

Running `pod install` will install the current version of RestKit, causing a `Podfile.lock` to be generated that indicates the exact version installed (e.g. `RestKit 0.10.3`). Thanks to the `Podfile.lock`, running `pod install` on this hypothetical project at a later point in time on a different machine will still install RestKit 0.10.3 even if a newer version is available. CocoaPods will honour the Pod version in `Podfile.lock` unless the dependency is updated in the Podfile or `pod update` is called (which will cause a new `Podfile.lock` to be generated). In this way CocoaPods avoids headaches caused by unexpected changes to dependencies.

This file should always be kept under version control.

## What is happening behind the scenes?

In Xcode, with references directly from the [ruby source](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L61-L65), it:

1. Creates or updates a [workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L82).
2. [Adds your project to the workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator.rb#L88-L94) if needed.
3. Adds the [CocoaPods static library project to the workspace](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/target_installer.rb#L40-L61) if needed.
4. Adds libPods.a to: [targets => build phases => link with libraries](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer.rb#L385-L393).
5. Adds the CocoaPods [Xcode configuration file](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L112) to your app’s project.
6. Changes your app's [target configurations](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/generator/xcconfig/aggregate_xcconfig.rb#L46-L73) to be based on CocoaPods's.
7. Adds a build phase to [copy resources from any pods](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer/user_project_integrator/target_integrator.rb#L145) you installed to your app bundle. i.e. a ‘Script build phase’ after all other build phases with the following:
  * Shell: `/bin/sh`
  * Script: `${SRCROOT}/Pods/PodsResources.sh`

<!-- (Expand the ‘To add a new build configuration…’ section of the linked page for a howto.) -->
  
Note that steps 3 onwards are skipped if the CocoaPods static library is already in your project. This is largely based on Jonah Williams' work on [Static Libraries](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4).

## Pods and Submodules

CocoaPods and git submodules attempt to solve very similar problems. Both strive to simplify the process of including 3rd party code in your project. Submodules link to a specific commit of that project, while a CocoaPod is tied to a versioned developer release.

### Switching from submodules to CocoaPods

Before you decide to make the full switch to CocoaPods, make sure that the libraries you are currently using are all available. It is also a good idea to record the versions of the libraries you are currently using, so that you can setup CocoaPods to use the same ones. It's also a good idea to do this incrementally, going dependency by dependency instead of one big move.

1. Install CocoaPods, if you have not done so already
2. Create your [Podfile](/using/the-podfile.html)
3. [Remove the submodule reference](http://davidwalsh.name/git-remove-submodule)
4. Add a reference to the removed library in your Podfile
5. Run `pod install`
