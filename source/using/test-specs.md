---
title: Testing with CocoaPods
description: This is a guide for working with test specifications and CocoaPods
order: 5
---

## Test Specifications

As of CocoaPods 1.3.0 pods may now provide test specifications (or test specs for short). Test specifications can be used to describe the test sources for a given pod.

> Here's an example `CoconutLib.podspec`, an imaginary library that defines a test spec:

```ruby
Pod::Spec.new do |s|
  s.name         = 'CoconutLib'
  s.version      = '1.0'
  s.authors      = 'Coconut Corp', { 'Monkey Boy' => 'monkey@coconut-corp.local' }
  s.homepage     = 'http://coconut-corp.local/coconut-lib.html'
  s.summary      = 'Coconuts For the Win.'
  s.description  = 'All the Coconuts'
  s.source       = { :git => 'http://coconut-corp.local/coconut-lib.git', :tag => 'v1.0' }
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE',
    :text => 'Permission is hereby granted ...'
  }
  s.source_files        = 'Classes/*.{h,m}'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/*.{h,m}'
    test_spec.dependency 'OCMock' # This dependency will only be linked with your tests.
  end  
end
```

Test specs are treated just like subspecs in terms of consuming them but they are different in how they are configured in the generated `Pods.xcodeproj`. Test spec sources and dependencies will not be included in the `CoconutLib` sources. You may choose to have multiple test specs in a podspec if you'd like to describe different parts of your pod with different test sources and dependencies.

In your `Podfile` you can bring the test specification as such:

```ruby
target 'MyApp' do
  use_frameworks!
  pod 'CoconutLib', '~> 1.0', :testspecs => ['Tests'] 
end
```

When you `pod install` this will automatically create a test target within the `Pods.xcodeproj` for the `CoconutLib` pod. You may choose to select that scheme and build and run your tests!

## Linting

`pod lib lint` and `pod spec lint` now have support for building and running your tests automatically when you lint your podspec. For example, linting the `CoconutLib.podspec` will automatically setup and run your tests provided by the given test specs. If you want to skip this step you may use the `--skip-tests` flag.

```ruby
pod lib lint CoconutLib.podspec --skip-tests
```

## Supported Test Types

As of right now, the supported test types are only for unit test bundles which require no app host to be executed. Support for test specs with app hosts will be added in the future.

