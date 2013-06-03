## What are Specs and what is the Specs Repo?

A Podspec, or Spec, describes a version of a Pod library. One Pod, over the course of time, will have many Specs. It includes details about where the source should be fetched from, what files to use, the build settings to apply, and other general metadata such as its name, version, and description. You can create one by hand, or run `pod spec create` to generate a stub.  

Here is an example spec:

```
Pod::Spec.new do |s|
  s.name         = 'Reachability'
  s.version      = '3.1.0'
  s.license      =  :type => 'BSD' 
  s.homepage     = 'https://github.com/tonymillion/Reachability'
  s.authors      =  'Tony Million' => 'tonymillion@gmail.com' 
  s.summary      = 'ARC and GCD Compatible Reachability Class for iOS and OS X. Drop in replacement for Apple Reachability.'
  s.source       =  :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' 
  s.source_files = 'Reachability.h,m'
  s.framework    = 'SystemConfiguration'
  s.requires_arc = true
end
```

The Specs Repo is the repository on GitHub that contains the list of all available pods. Every library has an individual folder, which contains sub folders of the available versions of that pod.  

See the Creating A Pod Repo section for an explanation of the Spec repo's file structure.

## Examples of Specifications

### A Simple specification.

```ruby
Pod::Spec.new do |s|
  s.name         = 'libPusher'
  s.version      = '1.3'
  s.license      = 'MIT'
  s.summary      = 'An Objective-C client for the Pusher.com service'
  s.homepage     = 'https://github.com/lukeredpath/libPusher'
  s.author       = 'Luke Redpath'
  s.source       = { :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3' }
  s.source_files = 'Library/*'
  s.requires_arc = true
  s.dependency 'SocketRocket'
end
```

### A specification with subspecs

```ruby
Pod::Spec.new do |s|
  s.name          = 'ShareKit'
  s.source_files  = 'Classes/ShareKit/{Configuration,Core,Customize UI,UI}/**/*.{h,m,c}', 'Classes/ShareKit/Sharers/Actions/**/*.{h,m,c}'
  # ...

  s.subspec 'Evernote' do |evernote|
    evernote.source_files = 'Classes/ShareKit/Sharers/Services/Evernote/**/*.{h,m}'
  end

  s.subspec 'Facebook' do |facebook|
    facebook.source_files   = 'Classes/ShareKit/Sharers/Services/Facebook/**/*.{h,m}'
    facebook.compiler_flags = '-Wno-incomplete-implementation -Wno-protocol -Wno-missing-prototypes'
    facebook.dependency 'Facebook-iOS-SDK'
  end
  # ...
end
```

In a podfile `require ShareKit` result in the inclusion of the whole library, while `require ShareKit/Facebook` can be used if you are interested only in the Facebook sharer.

### A specification with subspecs from submodules

If you have some submodules in the repository you need to set to `true` the `:submodules` key of the `s.source` Hash.
Then you'll be able to specify subspec like above.

```ruby
Pod::Spec.new do |s|
  s.name          = 'SDLoginKit'
  s.source   = { :git => 'https://github.com/dulaccc/SDLoginKit.git', :commit => '25e0464', :submodules => true }
  s.source_files = 'SDLoginKit/**/*.{h,m}'
  # ...

  s.subspec 'SDKit' do |sdkit|
    sdkit.source_files = 'SDKit/**/*.{h,m}'
    sdkit.resources = 'SDKit/**/Assets/*.png'
  end
  # ...
end
```

## How does the Specs Repo work?

To ensure a high quality, reliable collection of Pods, the Specs Repo is
strict about the podspecs added. One of the primary purposes of this repo is to guarantee the integrity of existing
CocoaPods installations.

When you are preparing a podspec for submission, you should make sure to do the following:

1. Run `pod spec lint`. This is used to validate specifications. Your podspec should pass without any errors or warnings.
2. Update your library to use [Semantic Versioning](http://semver.org/), if it already does not follow that scheme. See our [wiki on cross dependency resolution](https://github.com/CocoaPods/Specs/wiki/Cross-dependencies-resolution-example) for more details.
3. Make sure any updates you submit do not break previous installations. Adding 1.1.3 to your library's folder in the Specs Repo should not remove any previous versions.


In general this means that:

- A specification cannot be deleted.
- Specifications can be updated only if they don't affect existing installations.
  - Broken specifications can be updated.
  - Subspecs can be added as they are included by the parent specification by default.
- Only authoritative versions are accepted.


## How do I update an existing Pod?

There are two ways to update an existing Pod spec.

###If you do not have push access to CocoaPods/Specs

1. Fork and clone `CocoaPods/Specs`.
2. In a single commit, add a folder for your Pod to the main list, as well as the Spec in the format described in the Creating a Pod Repo section.
3. Run `pod spec lint` to check for errors.
4. If the linter produces errors or warnings, fix them and go back to step 3. If not, continue on.
5. Make your pull request to the master Specs Repo.

###If you have push access to CocoaPods/Specs

1. Clone `CocoaPods/Specs` locally.
2. In a single commit, add a folder for your Pod to the main list, as well as the Spec in the format described in the Creating a Pod Repo section.
3. Run `pod spec lint` to check for errors.
4. If the linter produces errors or warnings, fix them and go back to step 3. If not, continue on.
5. Push your changes to the master Specs repo

## How do I create a new Pod?

The following file structure is suggested:

```
.
├── Classes
    └── ios
    └── osx
├── Resources
├── Example
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

## My library depends on a podspec that is not in the Specs repository

**TODO**
