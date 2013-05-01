## How does the Specs Repo work?

To ensure a high quality, reliable collection of Pods, the master repo is
strict about the acceptable specifications. The CocoaPods linter (see the `pod
spec lint` command) is used to validate specifications, and no errors or warnings
are accepted.

The highest priority of the master repo is to guarantee the integrity of existing
CocoaPods installations.

In general this means that:

- A specification cannot be deleted.
- Specifications can be updated only if they don't affect existing installations.
  - Broken specifications can be updated.
  - Subspecs can be added as they are included by the parent specification by default.
- Only authoritative versions are accepted.

CocoaPods uses a versioning scheme known as [Semantic
Versioning](http://semver.org/), necessary for [cross resolution of
dependencies](https://github.com/CocoaPods/Specs/wiki/Cross-dependencies-resolution-example).

## How do I update an existing Pod?

**TODO**

## How do I create a new Pod?

The following file structure is suggested:

```
.
├── Classes
    └── ios
    └── osx
├── Resources
├── Project
    └── Podfile
├── LICENSE
├── Readme.markdown
└── NAME.podspec
```

The suggested Project/Podfile

```ruby
 platform :ios
#platform :osx

 podspec :path => "../NAME.podspec"
```

The `podspec` is a shortcut to require all the dependencies specified in `NAME.podspec`.

### Development

You can work on the library from its project. Alternatively you can work from an application project using the `:path` option:

```ruby
pod 'Name', :path => '~/code/Pods/NAME.podspec'
```

You can also lint the pod against the files of its directory:

```shell
$ cd ~/code/Pods/NAME
$ pod spec lint --local
```

### Release

The release workflow can be the following.

```shell
$ cd ~/code/Pods/NAME
$ edit NAME.podspec
# set the new version to 0.0.1
# set the new tag to 0.0.1
$ pod spec lint --local

$ git add -A && git commit -m "Release 0.0.1."
$ git tag '0.0.1'
$ git push --tags
$ pod push master
```

You can also simplify the podspec to skip a step:

```ruby
 s.version = '1.0.0'
 s.source = { :git => "https://example.com/repo.git", :tag => s.version.to_s }
#s.source = { :git => "https://example.com/repo.git", :tag => "v#{s.version}" }
```

## Creating a Pod repo

A specification repository is a simple collection of podspec files organized with the following structure:

```
NAME/VERSION/NAME.podspec
```

```console
$ cd ~/.cocoapods/master
$ tree | head
.
└── A2DynamicDelegate
    └── 1.0
        └── A2DynamicDelegate.podspec
        1.0.1
        └── A2DynamicDelegate.podspec
        1.0.2
        └── A2DynamicDelegate.podspec
        1.0.3
        └── A2DynamicDelegate.podspec
```

Although the master repo is backed by a git repository, this is not required. For a repository to be valid it is only required to respect the above described file structure.

CocoaPods stores its repositories in the `~/.cocoapods/` folder.

### Adding a new repo

###### Manually

1. Make a folder with the name of the repo in `~/.cocoapods/`.
2. Populate the repository with podspecs respecting the required folder structure.

###### From an existing git remote

If you want to create a git backed repository you can use the `$ pod repo add` command.

### Disambiguation

If during the installation process is resolved a Pod whose required version is present in more than one repository, the alphabetical order of the names is used to disambiguate.

**TODO:**

- How do I podify an existing project?
- How do I test the new Pod
- Local Pods?

## Versioning

There is, unfortunately, often an issue of developers not interpreting version
numbers well or assigning emotional value to certain version numbers.

However, arbitrary revisions as version is not a good idea for a library
manager instead of a proper version number (see [Semantic
Versioning](http://semver.org)). Let us explain how, in an ideal world, we’d
prefer people to interact with it:

* “I want to start using CocoaLumberjack, the current version will be fine for
  now.” So the dev adds a dependency on the lib _without_ a version requirement
  and lets the manager install it which will use the latest version:

        pod 'CocoaLumberjack'

* Some time into the future, the dev wants to update the dependencies, and to do so runs
  the install command again, which will now install the version of the lib
  which is the latest version _at that time_.

* At some point the dev is finished on the client work (or a newer version of
  the lib changes the API and the changes aren’t needed) so the dev adds a
  version requirement to the dependency. For instance, consider that the author
  of the lib follows the semver guidelines, you can somewhat trust that between
  ‘1.0.7’ and ‘1.1.0’ **no** API changes will be made, but only bug fixes. So
  instead of requiring a specific version, the dev can specify that _any_
  ‘1.0.x’ is allowed as long as it’s higher than ‘1.0.7’:

        pod 'CocoaLumberjack', '~> 1.0.7'


The point is that developers can easily keep track of newer versions of dependencies,
by simply running `pod install` again, which they might otherwise do less if
they had to change everything manually.

### CocoaPods Versioning Specifics

CocoaPods uses RubyGems versions for specifying pod spec versions. The
[RubyGems Versioning Policies](http://docs.rubygems.org/read/chapter/7)
describes the rules used for interpreting version numbers. The [RubyGems
version specifiers](http://docs.rubygems.org/read/chapter/16#page74) describes
exactly how to use the comparison operators that specify dependency versions.

Following the pattern established in RubyGems, pre-release versions can also be
specified in CocoaPods. A pre-release of version 1.2, for example, can be
specified by '1.2.beta.3'. In this example, the dependency specifier '~>
1.2.beta' will match '1.2.beta.3'.


## Documenting a Pod

**TODO**

## Where can I ask questions?

**TODO**: [Mailing List](http://groups.google.com/group/cocoapods) | Announcements and support. Feel free to ask any kind of question.

## I want to create a private repository

**TODO**