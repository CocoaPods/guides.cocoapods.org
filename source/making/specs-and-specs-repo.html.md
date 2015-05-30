---
title: Specs and the Specs Repo
description: Learn about creating Podspec's and the Spec repo.
order: 1
---

A Podspec, or Spec, describes a version of a Pod library. One Pod, over the course of time, will have many Specs. It includes details about where the source should be fetched from, what files to use, the build settings to apply, and other general metadata such as its name, version, and description.

You can create one by hand, or run `pod spec create` to generate a stub. Podspecs are ruby files.

> Here is an example spec:

```ruby
Pod::Spec.new do |spec|
  spec.name             = 'Reachability'
  spec.version          = '3.1.0'
  spec.license          =  :type => 'BSD' 
  spec.homepage         = 'https://github.com/tonymillion/Reachability'
  spec.authors          = 'Tony Million' => 'tonymillion@gmail.com'
  spec.summary          = 'ARC and GCD Compatible Reachability Class for iOS and OS X.'
  spec.source           =  :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' 
  spec.source_files     = 'Reachability.h,m'
  spec.framework        = 'SystemConfiguration'
  spec.requires_arc     = true
end
```

The [Specs Repo](https://github.com/CocoaPods/Specs) is the repository on GitHub that contains the list of all available pods. Every library has an individual folder, which contains sub folders of the available versions of that pod.  

See the [Private Pods](private-cocoapods.html) section for an explanation of the Spec repo's file structure.

## Examples of Specifications

> A Simple specification.

```ruby
Pod::Spec.new do |spec|
  spec.name         = 'libPusher'
  spec.version      = '1.3'
  spec.license      = 'MIT'
  spec.summary      = 'An Objective-C client for the Pusher.com service'
  spec.homepage     = 'https://github.com/lukeredpath/libPusher'
  spec.author       = 'Luke Redpath'
  spec.source       =  :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3'
  spec.source_files = 'Library/*'
  spec.requires_arc = true
  spec.dependency 'SocketRocket'
end
```

> A specification with subspecs

```ruby
Pod::Spec.new do |spec|
  spec.name          = 'ShareKit'
  spec.source_files  = 'Classes/ShareKit/{Configuration,Core,Customize UI,UI}/**/*.{h,m,c}'
  # ...

  spec.subspec 'Evernote' do |evernote|
    evernote.source_files = 'Classes/ShareKit/Sharers/Services/Evernote/**/*.{h,m}'
  end

  spec.subspec 'Facebook' do |facebook|
    facebook.source_files   = 'Classes/ShareKit/Sharers/Services/Facebook/**/*.{h,m}'
    facebook.compiler_flags = '-Wno-incomplete-implementation -Wno-missing-prototypes'
    facebook.dependency 'Facebook-iOS-SDK'
  end
  # ...
end
```

[Subspecs](/syntax/podspec.html#group_subspecs) are a way of chopping up the functionality of a Podspec, allowing people to install a subset of your library. 

With the above example a Podfile using `pod 'ShareKit'` results in the inclusion of the whole library, while `pod 'ShareKit/Facebook'` can be used if you are interested only in the Facebook specific parts.

### A specification with subspecs within submodules

If you have some submodules in the repository you need to set the `:submodules` key of the `s.source` hash to true.
Then you'll be able to specify subspec like above.

```ruby
Pod::Spec.new do |spec|
  spec.name          = 'SDLoginKit'
  spec.source        =  { 
      :git => 'https://github.com/dulaccc/SDLoginKit.git',
      :tag => '1.0.2', 
      :submodules => true 
  }
  # ...

  spec.subspec 'SDKit' do |sdkit|
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

1. Run `pod spec lint`. This is used to validate specifications. Your podspec should pass without any errors or warnings.
2. Update your library to use [Semantic Versioning](http://semver.org/), if it already does not follow that scheme. See our [wiki on cross dependency resolution](https://github.com/CocoaPods/Specs/wiki/Cross-dependencies-resolution-example) for more details. Essentially it makes everyone's life easier.
3. Make sure any updates you submit do not break previous installations.
4. Perform manual testing of your Podspec by [including the local Podspec](/syntax/podfile.html#pod) in the Podfile of a real application and/or your demo application, and ensuring it works as expected. **You alone** are responsible for ensuring your Podspec functions properly for your users.

In general this means that:

- A specification cannot be deleted.
- Specifications can be updated only if they don't affect existing installations.
  - Broken specifications can be updated.
  - Subspecs can be added as they are included by the parent specification by default.
- Only authoritative versions are accepted.

## How do I update an existing Pod?

1. Create your Podspec as described above.
2. Run `pod spec lint` to check for errors.
3. Submit your Podspec to Trunk with `pod trunk push NAME.podspec`

## How do I get my library on CocoaDocs?

[CocoaDocs](http://cocoadocs.org) receives notifications from the [CocoaPods/Specs](https://github.com/CocoaPods/Specs) repo on GitHub whenever a CocoaPod is updated. This triggers a process that will generate documentation for _objective-c_ projects via [appledoc](http://gentlebytes.com/appledoc/) and host them for the community. This process can take around 15 minutes after your Podspec is merged. If you host your own documentation, you can use the [documentation_url](/syntax/podspec.html#documentation_url).

