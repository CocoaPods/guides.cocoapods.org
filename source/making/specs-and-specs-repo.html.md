---
title: Specs and the Specs Repo
description: Learn about creating Podspec's and the Spec repo.
---

A Podspec, or Spec, describes a version of a Pod library. One Pod, over the course of time, will have many Specs. It includes details about where the source should be fetched from, what files to use, the build settings to apply, and other general metadata such as its name, version, and description. You can create one by hand, or run `pod spec create` to generate a stub. Podspecs are ruby files.

> Here is an example spec:

```ruby
Pod::Spec.new do |s|
  s.name          = 'Reachability'
  s.version       = '3.1.0'
  s.license       =  :type => 'BSD' 
  s.homepage      = 'https://github.com/tonymillion/Reachability'
  s.authors       =  'Tony Million' => 'tonymillion@gmail.com' 
  s.summary       = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  s.source        =  :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' 
  s.source_files  = 'Reachability.h,m'
  s.framework     = 'SystemConfiguration'
  s.requires_arc  = true
end
```

The Specs Repo is the repository on GitHub that contains the list of all available pods. Every library has an individual folder, which contains sub folders of the available versions of that pod.  

See the [Private Pods](making/private-cocoapods.html) section for an explanation of the Spec repo's file structure.

## Examples of Specifications

> A Simple specification.

```ruby
Pod::Spec.new do |s|
  s.name         = 'libPusher'
  s.version      = '1.3'
  s.license      = 'MIT'
  s.summary      = 'An Objective-C client for the Pusher.com service'
  s.homepage     = 'https://github.com/lukeredpath/libPusher'
  s.author       = 'Luke Redpath'
  s.source       =  :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3'
  s.source_files = 'Library/*'
  s.requires_arc = true
  s.dependency 'SocketRocket'
end
```

> A specification with subspecs

```ruby
Pod::Spec.new do |s|
  s.name          = 'ShareKit'
  s.source_files  = 'Classes/ShareKit/{Configuration,Core,Customize UI,UI}/**/*.{h,m,c}'
  # ...

  s.subspec 'Evernote' do |evernote|
    evernote.source_files = 'Classes/ShareKit/Sharers/Services/Evernote/**/*.{h,m}'
  end

  s.subspec 'Facebook' do |facebook|
    facebook.source_files   = 'Classes/ShareKit/Sharers/Services/Facebook/**/*.{h,m}'
    facebook.compiler_flags = '-Wno-incomplete-implementation -Wno-missing-prototypes'
    facebook.dependency 'Facebook-iOS-SDK'
  end
  # ...
end
```

[Subspecs](specification.html#subspec) are a way of chopping up the functionality of a Podspec, allowing people to install a subset of your library. With the above example a Podfile using `require ShareKit` results in the inclusion of the whole library, while `require ShareKit/Facebook` can be used if you are interested only in the Facebook specific parts.

### A specification with subspecs within submodules

If you have some submodules in the repository you need to set the `:submodules` key of the `s.source` hash to true.
Then you'll be able to specify subspec like above.

```ruby
Pod::Spec.new do |s|
  s.name          = 'SDLoginKit'
  s.source        =  { 
      :git => 'https://github.com/dulaccc/SDLoginKit.git',
      :tag => '1.0.2', 
      :submodules => true 
  }
  # ...

  s.subspec 'SDKit' do |sdkit|
    sdkit.source_files = 'SDKit/**/*.{h,m}'
    sdkit.resources    = 'SDKit/**/Assets/*.png'
  end
  # ...
end
```

## How does the Specs Repo work?

To ensure a high quality, reliable collection of Pods, the Specs Repo is
strict about the podspecs added. One of the primary purposes of this repo is to guarantee the integrity of existing
CocoaPods installations.

When you are preparing a podspec for submission, you should make sure to do the following:

1. Run `pod spec lint`. This is used to validate specifications. <br/>Your podspec should pass without any errors or warnings.
2. Update your library to use [Semantic Versioning](http://semver.org/), if it already does not follow that scheme. See our [wiki on cross dependency resolution](https://github.com/CocoaPods/Specs/wiki/Cross-dependencies-resolution-example) for more details. Essentially it makes everyone's life easier.
3. Make sure any updates you submit do not break previous installations. Adding 1.1.3 to your library's folder in the Specs Repo should not remove any previous versions.

In general this means that:

- A specification cannot be deleted.
- Specifications can be updated only if they don't affect existing installations.
  - Broken specifications can be updated.
  - Subspecs can be added as they are included by the parent specification by default.
- Only authoritative versions are accepted.

## How do I update an existing Pod?

* ### If you do not have push access to CocoaPods/Specs
  1. Fork and clone `CocoaPods/Specs`.
  2. In a single commit, add a folder for your Pod to the main list, as well as the Spec in the format described in the Creating a Pod Repo section.
  3. Run `pod spec lint` to check for errors.
  4. If the linter produces errors or warnings, fix them and go back to step 3. If not, continue on.
  5. Make your pull request to the master Specs Repo.

* ### If you have push access to CocoaPods/Specs
  1. Clone `CocoaPods/Specs` locally.
  2. In a single commit, add a folder for your Pod to the main list, as well as the Spec in the format described in the Creating a Pod Repo section.
  3. Run `pod spec lint` to check for errors.
  4. If the linter produces errors or warnings, fix them and go back to step 3. If not, continue on.
  5. Push your changes to the master Specs repo