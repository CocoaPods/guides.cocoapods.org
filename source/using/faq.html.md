---
title: F.A.Q
description: Is CocoaPods ready for prime-time? Why not just use git submodules? etc. etc.
order: 4
---

### "Will CocoaPods stop development now that Swift has a built-in package manager?"

  As of writing, the [Swift Package Manager (SPM)](https://github.com/apple/swift-package-manager) is in "early design and development" [[1]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/README.md#a-work-in-progress). It  does not currently support iOS, OS X, watch OS, or Objective-C [[2]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/Package.swift.md#depending-on-apple-modules-eg-foundation)[[3]](https://github.com/apple/swift-package-manager/blob/14f47ad34967c7e7808863fb29fa3f9baf5db7a4/Documentation/PackageManagerCommunityProposal.md#support-for-other-languages). CocoaPods will continue development supporting both Swift and Objective-C while SPM develops. As SPM approaches maturity, we will evaluate the best course forward for CocoaPods and the CocoaPods community.


### “Why not just use git submodules?”

  CocoaPods is **not** about downloading code. While it does do that, it’s arguably the least interesting part.

  What defines CocoaPods are the (cross) dependency resolution, (semantic) version management, and automating the ‘integrating it into Xcode’ parts.

  Finally, even if you’re looking just for a downloader, consider that there are in fact other SCMs being used than just git. CocoaPods, on the other hand, is agnostic and handles Subversion, Mercurial, and zip/tarballs from local or HTTP locations.

### “How can I donate to CocoaPods?”

  TL;DR: While we very much appreciate the sentiment, the project (as an entity) does not accept financial donations. We have a [great blog post](https://blog.cocoapods.org/Why-we-dont-accept-donations/) on this.

### “CocoaPods doesn’t do X, so it’s unusable.”

  First see point #2, then consider that unless you tell us about the missing feature and why it is important, it won’t happen at all. We don’t scour Twitter to look for work, so please file a [ticket](https://github.com/CocoaPods/CocoaPods/issues/new), or, better yet, in the form of a pull-request.


### “CocoaPods doesn’t do dependency resolution.”

  CocoaPods has always done dependency resolution, but until version 0.35 it lacked automatic conflict resolution. As of now, CocoaPods can resolve any conflict that is possible to resolve.


### “CocoaPods is bad for the community, because it makes it too easy for users to add many dependencies.”

 This is akin to saying "we should not have cars", as they make us lazy and we forget walking/running. Or "we should not use [IDEs](http://programmers.stackexchange.com/questions/39798/being-ide-dependent-how-can-it-harm-me/39809#39809)" as they make us bad programmers, who can't code in editor and can't remember syntax. Furthermore, this reasoning applies to basically any means of fetching code (e.g. git) and as such is not a discussion worth having.

  What _is_ worth discussing, however, is informing the user to be responsible. Ironically enough, the original author of CocoaPods is convinced using a lot of dependencies is a really bad idea. For practical advice on how to deal with this, you should read [this blog post](http://www.fngtps.com/2013/a-quick-note-on-minimal-dependencies-in-ruby-on-rails/) by [Manfred Stienstra](https://twitter.com/manfreds).


### “CocoaPods uses workspaces, which are considered user data. Why does it not use normal sub-projects?”

  Starting from Xcode 4, [Apple introduced workspaces for this very purpose](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html).

  Since then, they have also added workspace files to each xcodeproj document, leading people to believe that a workspace is user data only. This is simply incorrect and you should **not** ignore workspace documents any longer, if you were doing so.

  Note that CocoaPods itself does not require the use of a workspace. If you prefer to use sub-projects, you can do so by running `pod install --no-integrate`, which will leave integration into your project up to you as you see fit.


### “Why do I have to install Ruby to use CocoaPods?”

  You don’t. OS X comes with a Ruby 2.0.0 or newer pre-installed in `/usr/bin/ruby` which are our baselines and these should work out of the box.
