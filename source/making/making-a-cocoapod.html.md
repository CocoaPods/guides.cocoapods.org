---
title: Making a CocoaPod
description: Instructions for creating and maintaining a CocoaPod.
order: 0

external links:
-
  Why your podspec is failing: http://codeslingers.co.uk/2014/05/16/why-your-podspec-is-failing/
---

Creating your own CocoaPod is fairly straight forward. If you already have a separate component, you're most of the way there. This guide is an overview to the entire process, with the other guides in this section serving as more of a deep-dive for more advanced users.

## The Pod Files

There are only a few differences between a CocoaPod and a generic open source library. The most important ones, aside from the actual source, are the `.podspec` and `LICENSE`. We do not accept libraries into the public master repo without a code license. For information on what license to choose, we suggest reading [this article on CodingHorror](http://www.codinghorror.com/blog/2007/04/pick-a-license-any-license.html) or [tl;dr Legal](http://www.tldrlegal.com/).

We recommend letting CocoaPods do the hard work here. Running `pod lib create [pod name]` will set you up with a well thought out library structure allowing you to easily include your files and get started quickly. In addition the template offers some terminal commands to automate a lot of the release / updating.

> The initial folder structure looks like this:

```
├── Assets
├── CHANGELOG.md
├── Classes
    └── ios
    └── osx
├── Example
    └── Podfile
├── LICENSE
├── README.md
├── Rakefile
└── NAME.podspec
```

> The suggested Example/Podfile:

```ruby
 platform :ios
#platform :osx

 podspec :path => "../NAME.podspec"
```

<aside>The `podspec` is a shortcut to require all the dependencies specified in `NAME.podspec`.</aside>

### Development

You can work on the library from its folder on your system. 

> Alternatively you can work from an application project using the `:path` option:

```ruby
pod 'Name', :path => '~/code/Pods/'
```

### Testing

You can test the syntax of your podfile by linting the  pod against the files of its directory, this won't test the downloading aspect of linting.

```shell
$ cd ~/code/Pods/NAME
$ pod lib lint
```

Before releasing your new Pod to the world its best to test that you can install your pod successfully into an Xcode project. You can do this in a couple of ways:

> Push your podspec to your repository, then create a new Xcode project with a Podfile and add your pod to the file liks so:

````ruby
pod 'NAME', :git => 'https://example.com/URL/to/repo/NAME.git'
````
> Then run

````shell
pod install 
-- or --
pod update
````

> Alternatively if you have a separate Xcode project for your unit tests you can use a podfile for this project that references your development podspec

````ruby
xcodeproj 'NAMETests'
workspace '../NAME'

pod 'NAME', :path => '../'
```` 

### Release

If you used `pod lib create` to generate your project you can run `rake release` in the Pod's root folder, which validate your build and pushes a release tag to your git repository. 

> The release workflow is similar to the following.

```shell
$ cd ~/code/Pods/NAME
$ edit NAME.podspec
# set the new version to 0.0.1
# set the new tag to 0.0.1
$ pod lib lint

$ git add -A && git commit -m "Release 0.0.1."
$ git tag '0.0.1'
$ git push --tags
```

#### Submitting Open Source Code

Once your tags are pushed you can use the command `pod trunk push NAME.podspec` to send your library to the Specs repo. For more information on getting this setup see [Getting Setup With Trunk](/making/getting-setup-with-trunk). 

#### Submitting Private Code

Once your tags are pushed you can use the command `pod repo push [repo] NAME.podspec` to send your library to the named private specs repo. For more information on getting this setup see [Private CocoaPods](/making/private-cocoapods).

## Library Versioning

There is, unfortunately, often an issue of developers not interpreting version numbers well or assigning emotional value to certain version numbers.

However, arbitrary revisions as version is not a good idea for a library manager instead of a proper version number (see [Semantic Versioning](http://semver.org)). Let us explain how, in an ideal world, we’d prefer people to interact with it:

* “I want to start using CocoaLumberjack, the current version will be fine for now.” So the dev adds a dependency on the lib _without_ a version requirement and `pod install`s which will use the latest version:

  <code>
  pod 'CocoaLumberjack'
  </code>

* Some time into the future, the dev wants to update the dependencies, and to do so runs the install command again, which will now install the version of the lib which is the latest version _at that time_.

* At some point the dev is finished on the client work (or a newer version of the lib changes the API and the changes aren’t needed) so the dev adds a version requirement to the dependency. For instance, consider that the author of the lib follows the semver guidelines, you can somewhat trust that between ‘1.0.7’ and ‘1.1.0’ **no** API changes will be made, but only bug fixes. So instead of requiring a specific version, the dev can specify that _any_ ‘1.0.x’ is allowed as long as it’s higher than ‘1.0.7’:

```ruby 
pod 'CocoaLumberjack', '~> 1.0.7'
```

The point is that developers can easily keep track of newer versions of dependencies, by simply running `pod install` again, which they might otherwise do less if they had to change everything manually. CocoaPods uses a less stringent form of Semantic versioning in that it will not force you to use `X.Y.Z`, you can use `X.Y` versions.

### CocoaPods Versioning Specifics

CocoaPods uses RubyGems versions for specifying pod spec versions. The [RubyGems Versioning Policies](http://docs.rubygems.org/read/chapter/7) describes the rules used for interpreting version numbers. The [RubyGems version specifiers](http://docs.rubygems.org/read/chapter/16#page74) describes exactly how to use the comparison operators that specify dependency versions.

Following the pattern established in RubyGems, pre-release versions can also be specified in CocoaPods. A pre-release of version 1.2, for example, can be specified by `1.2-beta3`. In this example, the dependency specifier `~> 1.2-beta` will match `1.2-beta3`.


## Documenting a Pod

Right now the best place to get information on documenting your Pods in anticipation of CocoaDocs and Xcode 5 support is via [NSHipster's blog post on Documentation](http://nshipster.com/documentation/). [CocoaDocs](http://github.com/cocoapods/cocoadocs.org) will release an appledoc parsed code based on your Podspec's public API roughly 15 minutes after it is pushed.

## Where can I ask questions?

We have multiple avenues for support, here they are in the order we prefer.

* [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods), get yourself some internet points. This keeps the pressure off the CocoaPods dev team and gives us time to work on the project and not support. One of the advantages of using Stack Overflow is that the answer is then easily accessible for others.

* [CocoaPods Mailing List](http://groups.google.com/group/cocoapods), the mailing list is mainly used for announcements of related projects and for support.
