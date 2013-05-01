## What are CocoaPods

CocoaPods manages library dependencies for your Xcode project.

The dependencies for your project are specified in a single text file. CocoaPods
resolves dependencies between libraries, fetches the source code, and creates and maintains an Xcode workspace to build your project.

Ultimately the goal is to improve discoverability of, and engagement in, third
party open-source libraries by creating a more centralized ecosystem.

## Installing CocoaPods

### Dependencies

- Ruby MRI 2.0.0 or 1.8.7 (ships with Mac OS X)
- Xcode command line tools.

### Installation

To install CocoaPods you can run:

    $ [sudo] gem install cocoapods

To enjoy performance benefits you can install a modern Ruby like 2.0.0 through a
Ruby version manager like [RVM](http://rvm.io). If you are using RVM, or equivalent, we suggest not using `sudo` as it may have some unintended effects on other parts of your system.

### Updating CocoaPods

To update CocoaPods you can run:

    $ [sudo] gem update cocoapods

If you would like to try a pre-release version of CocoaPods you can run:

    $ [sudo] gem update cocoapods --pre


### Troubleshooting

- The gem might not be able to compile, to solve this you might need to symlink
  GCC.

- If you used an pre release version of Xcode you might need to update the
  command line tools.

- CocoaPods is not compatible with MacRuby.


## What is a Podfile?


 The Podfile is a specification that describes the dependencies of the
 targets of one or more Xcode projects. The Podfile always creates an
 implicit target, named `default`, which links to the first target of the
 user project.

 A podfile can be very simple:

     pod 'AFNetworking', '~> 1.0'

 An example of a more complex podfile can be:

     platform :ios, '6.0'
     inhibit_all_warnings!

     xcodeproj `MyProject`

     pod 'ObjectiveSugar', '~> 0.5'

     target :test do
       pod 'OCMock', '~> 2.0.1'
     end

     post_install do |installer|
       installer.project.targets.each do |target|
         puts "#{target.name}"
       end
     end

When starting out with a project it is likely that you will want to use
the latest version of a Pod. If this is the case, simply omit the
version requirements.

    pod 'SSZipArchive'


Later on in the project you may want to freeze to a specific version of
a Pod, in which case you can specify that version number.

    pod 'Objection', '0.9'


Besides no version, or a specific one, it is also possible to use
operators:

* `> 0.1`    Any version higher than 0.1
* `>= 0.1`   Version 0.1 and any higher version
* `< 0.1`    Any version lower than 0.1
* `<= 0.1`   Version 0.1 and any lower version
* `~> 0.1.2` Version 0.1.2 and the versions up to 0.2, not including 0.2

A list of version requirements can be specified for even more fine
grained control.

For more information, regarding versioning policy, see:

* [Semantic Versioning](http://semver.org)
* [RubyGems Versioning Policies](http://docs.rubygems.org/read/chapter/7)

Finally, instead of a version, you can specify the `:head` flag. This
will use the pod’s latest version spec version, but force the download
of the ‘bleeding edge’ version. Use this with caution, as the spec
might not be compatible anymore.

    pod 'Objection', :head


### Using the files from a folder local to the machine.

If you wold like to use develop a Pod in tandem with its client
project you can use the `local` option.

    pod 'AFNetworking', :path => '~/Documents/AFNetworking'

Using this option CocoaPods will assume the given folder to be the
root of the Pod and will link the files directly from there in the
Pods project. This means that your edits will persist to CocoaPods
installations.

The referenced folder can be a checkout of your your favorite SCM or
even a git submodule of the current repo.

Note that the `podspec` of the Pod file is expected to be in the
folder.


### From a podspec in the root of a library repo.

Sometimes you may want to use the bleeding edge version of a Pod. Or a
specific revision. If this is the case, you can specify that with your
pod declaration.

To use the `master` branch of the repo:

    pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git'


Or specify a commit:

    pod 'AFNetworking', :git => 'https://github.com/gowalla/AFNetworking.git', :commit => '082f8319af'

It is important to note, though, that this means that the version will
have to satisfy any other dependencies on the Pod by other Pods.

The `podspec` file is expected to be in the root of the repo, if this
library does not have a `podspec` file in its repo yet, you will have
to use one of the approaches outlined in the sections below.


### Integrating with an Xcode project

#### Before you begin

1. Check the [Specs](http://github.com/CocoaPods/Specs) repository to make sure the libraries you would like to use are available.
2. [Install CocoaPods on your computer][installing-cocoapods].

### Installation

1. Create a [Podfile][podfile], and add your dependencies:

```
    pod 'AFNetworking', '~> 1.0'  
    pod 'ObjectiveSugar', '~> 0.5'
```

2. Run `$ pod install` in your project directory.
3. Open `App.xcworkspace` and build.

**TODO**:

- How do I start a new project with Cocoapods?
- How do I add Cocoapods to my existing project that already uses a workspace?

## Should I check in my pods folder?

**TODO**

## What is a Podfile.lock

This file keeps track of what version of a Pod is installed. For example the
following dependency might install RestKit 0.10.3:

    pod 'RestKit'

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

## CocoaPods Philosophy

### Goal

CocoaPods' goal is to improve discoverability of, and engagement in, third party
open-source libraries, by creating a more centralized ecosystem.

### Common Misconceptions

#### 1. “CocoaPods is not ready for prime-time yet.”

Correct. Version 1.0.0 will be the milestone where we feel confident that all
the basic requirements of an Objective-C dependency manager are fulfilled.

Once we reach the 1.0.0 milestone, we will, for the first time ever, contact
the community at large through mailing-lists such as cocoa-dev.

#### 2. “CocoaPods doesn’t do X, so it’s unusable.”

First see point #1, then consider that unless you tell us about the missing
feature and why it is important, it won’t happen at all. We don’t scour Twitter
to look for work, so please file a
[ticket](https://github.com/CocoaPods/CocoaPods/issues/new), or, better yet, start a pull-request.

#### 3. “CocoaPods doesn’t do dependency resolution.”

CocoaPods does in fact do dependency resolution, but it does not automatically
resolve conflicts. This means that when a conflict occurs, CocoaPods will
raise an error and leave conflict resolving up to the user. (The user can do
this by depending on a specific version of a common dependency _before_
requiring the dependencies that lead to the conflict.)

If you’re familiar with Ruby then you can compare the former (the current
CocoaPods style) to RubyGems’ style resolution and the latter (with conflict
resolving) to Bundler’s.

Adding conflict resolution to CocoaPods is on our TODO list and we will try to
work with the Bundler team to see if we can share their algorithm, but this
will be one of the last things we’ll work on. A feature like this will require
a stable basis and since we’re not there yet, working on it now would only make
working on the basics more complex than necessary.

Finally, while conflict resolving is a definite must-have, you should ask
yourself if you’re not using too many dependencies whenever you run into
conflicts, as this is in general a good indicator. See the link to a blog post
about this in #4.


#### 4. “CocoaPods is bad for the community, because it makes it too easy for users to add many dependencies.”

This is akin to saying “guns kill people”, but everybody knows it’s really
people who kill people (and [psychotic bears with
machetes](http://www.sebastienmillon.com/Machete-Bear-Art-Print-15-00)).
Furthermore, this reasoning applies to basically any means of fetching code
(e.g. git) and as such is not a discussion worth having.

What _is_ worth discussing, however, is informing the user to be responsible.
Ironically enough, the original author of CocoaPods is convinced using a lot of
dependencies is a really bad idea. For practical advice on how to deal with
this, you should read [this blog post](http://www.fngtps.com/2013/a-quick-note-on-minimal-dependencies-in-ruby-on-rails/)
by [Manfred Stienstra](http://twitter.com/manfreds).


#### 5. “CocoaPods uses workspaces, which are considered user data. Why does it not use normal sub-projects?”

Beginning in Xcode 4, [Apple introduced workspaces for this very
purpose](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html).

Since then, they have also added workspace files to each `.xcodeproj` document,
leading people to believe that a workspace is user data only. This is simply
incorrect and you should **not** ignore workspace documents any longer if you
were doing so.

Note that CocoaPods itself does not require the use of a workspace. If you
prefer to use sub-projects, you can do so by running `pod install
--no-integrate`, which will leave integration into your project up to you as
you see fit.
