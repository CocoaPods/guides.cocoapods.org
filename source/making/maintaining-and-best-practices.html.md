---
title: Maintaining & Best Practices
description: Instructions for creating and maintaining a CocoaPod
order: 3
---

<!-- TODO: Using the pod lib create command -->


This guide gathers best practices for Cocoa library authors. The goal is to make integration of libraries easier for everyone, using CocoaPods or not. Ultimately, [CocoaPods will leverage](https://github.com/CocoaPods/CocoaPods/issues/1024) existing Xcode projects to build libraries, so this will require some rigor from library authors.

## What should be the structure of a library project?

* Xcode workspace
  * Library project
    * Source Code
    * Headers (public/project/private, Copy Files vs Copy Headers)
    * Resources
    * Frameworks (indicative)
    * `DYLIB_COMPATIBILITY_VERSION` (semver)
  * App project
    * `HEADER_SEARCH_PATHS` + `#import <Lib/Lib.h>`

* Separate Demo app project
* Implicit Dependencies
* Multiple (dependent) libraries
* License
* Difference between `#import` in source files and header files

### Resource bundle

* http://www.cocoanetics.com/2012/05/resource-bundles/
* http://www.galloway.me.uk/tutorials/ios-library-with-resources/

### Subspecs

* Several static library targets
