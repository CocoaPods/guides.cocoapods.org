---
title: Using CocoaPods
description: Integration instructions and best practices
---

### Adding Pods to an Xcode project

#### Before you begin

1. Check the [Specs](http://github.com/CocoaPods/Specs) repository or [cocoapods.org](http://cocoapods.org) to make sure the libraries you would like to use are available.
2. [Install CocoaPods on your computer][installing-cocoapods].

### Installation

1. Create a [Podfile][podfile], and add your dependencies:

```ruby
pod 'AFNetworking', '~> 1.0'  
pod 'ObjectiveSugar', '~> 0.5'
```

2. Run `$ pod install` in your project directory.
3. Open `App.xcworkspace` and build.

####Creating a new Xcode project with CocoaPods

To create a new project with CocoaPods, follow these simple steps:

1. Create a new project in Xcode as you would normally.
2. Open a terminal window, and `$ cd` into your project directory.
3. Create a Podfile. This can be done by running `$ touch Podfile`.
4. Open your Podfile. The first line should specify the platform and version supported.

```ruby
platform :ios, '6.0'
````

5. Add a CocoaPod by specifying `pod '$PODNAME'` on a single line

```ruby
pod 'ObjectiveSugar'
```
6. Save your Podfile.
7. Run `$ pod install`
8. Open the `MyApp.xcworkspace` that was created. This should be the file you use everyday to create your app.

####Integration with an existing workspace

Integrating CocoaPods with an existing workspace requires one extra line in your Podfile. Simply specify the `.xcworkspace` like so:

```ruby
xcodeproj `MyProject`
```

## Should I check in my pods folder?

Whether or not you check in your Pods folder is up to you, as workflows vary from project to project. Here are some pros and cons to think about when setting up your project:

##### Pros

- Smaller repo under source control
- CocoaPods given the availability of the sources is capable to recreate (almost) the same exact installation. 
- No conflicts to handle in the dependencies of the management system of source control.

##### Cons

- The sources of the Pods can go down.
- External sources are not recreated perfectly (at the moment the commit is not used) and in some cases will never be (zip files)
- Requires internet connection and the installation of CocoaPods for clients of the project.

## What is a Podfile.lock

This file keeps track of what version of a Pod is installed. For example the
following dependency might install RestKit 0.10.3:

```ruby
pod 'RestKit'
```

Thanks to the `Podfile.lock` every machine which runs pod install on the
hypothetical project will use RestKit 0.10.3 even if a newer version is
available. CocoaPods will honor this version unless the dependency is updated
on the Podfile or `pod update` is called. In this way CocoaPods avoids headaches
caused by unexpected changes to dependencies.

This file should always be kept under version control.

## What is happening behind the scenes?

In Xcode, it:

1. [Creates or updates a workspace.][creating-a-workspace]
2. [Adds your project to the workspace if needed.][adding-projects-to-workspace]
3. [Adds the CocoaPods static library project to the workspace if needed.][adding-projects-to-workspace]
4. [Adds libPods.a to: targets => build phases => link with libraries.][adding-build-target-dependencies]
5. Adds the CocoaPods Xcode configuration file to your app’s project.
6. [Changes your app's target configurations to be based on CocoaPods's.][basing-target-configurations-on-xcconfig] (Expand the ‘To add a new build configuration…’ section of the linked page for a howto.)
7. Adds a build phase to copy resources from any pods you installed to your app bundle. i.e. a ‘Script build phase’ after all other build phases with the following:
  * Shell: `/bin/sh`
  * Script: `${SRCROOT}/Pods/PodsResources.sh`

Note that steps 3 onwards are skipped if the CocoaPods static library is already in your project.

This is largely based on [http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4).  

## Pods and Submodules

CocoaPods and git submodules attempt to solve very similar problems. Both strive to simplify the process of including 3rd party code in your project. Submodules link to a specific commit of that project, while a CocoaPod is tied to a versioned developer release.

### Switching from submodules to CocoaPods

Before you decide to make the full switch to CocoaPods, make sure that the libraries you are currently using are all available. It is also a good idea to record the versions of the libraries you are currently using, so that you can setup CocoaPods to use the same ones.

1. Install CocoaPods, if you have not done so already
2. Remove the `.gimodules` file
3. Remove the repositories from `.git/config`
4. Create your Podfile
5. Run `pod install`

### Switching from CocoaPods to submodules

**TODO**