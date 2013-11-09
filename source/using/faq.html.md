---
title: F.A.Q
description: Is CocoaPods ready for prime-time? Why not just use git submodules? etc. etc.
order: 4
---

### “Why not just use git submodules?”

  CocoaPods is **not** about downloading code. While it does do that, but it’s arguably the least interesting part.

  What defines CocoaPods are the (cross) dependency resolution, (semantic) version management, and automating the ‘integrating it into Xcode’ parts.

  Finally, even if you’re looking just for a downloader, consider that there are in fact other SCMs being used than just git. CocoaPods, on the other hand, is agnostic and handles Subversion, Mercurial, and zip/tarballs from local or HTTP locations.


### “CocoaPods is not ready for prime-time yet.”

  Correct. Version 1.0.0 will be the milestone where we feel confident that all the basic requirements of a Objective-C dependency manager are fulfilled.

  Once we reach the 1.0.0 milestone we will –for the first time ever– contact the community at large through mailing-lists such as cocoa-dev.


### “How can I donate to CocoaPods?”

  TL;DR: While we very much appreciate the sentiment, the project (as an entity) does not accept financial donations. We have a [great blog post](http://blog.cocoapods.org/Why-we-dont-accept-donations/) on this.

### “CocoaPods doesn’t do X, so it’s unusable.”

  First see point #2, then consider that unless you tell us about the missing feature and why it is important, it won’t happen at all. We don’t scour Twitter to look for work, so please file a [ticket](https://github.com/CocoaPods/CocoaPods/issues/new), or, better yet, in the form of a pull-request.


### “CocoaPods doesn’t do dependency resolution.”

  CocoaPods does in fact do dependency resolution, but it does not automatically resolve conflicts. This means that, when a conflict occurs, CocoaPods will raise an error and leave conflict resolving up to the user. (The user can do this by depending on a specific version of a common dependency _before_ requiring the dependencies that lead to the conflict.)

  If you’re familiar with Ruby then you can compare the former (the current CocoaPods style) to RubyGems’ style resolution and the latter (with conflict resolving) to Bundler’s. (See [this](http://patshaughnessy.net/2011/9/24/how-does-bundler-bundle) article for a detailed look at Bundler’s process.)

  Adding conflict resolution to CocoaPods is on our TODO list and we will try to work with the Bundler team to see if we can share their algorithm, but this will be one of the last things we’ll work on. A feature like this will require a stable basis and since we’re not there yet, working on it now would only make working on the basis more complex than necessary.

  Finally, while conflict resolving is a definite must-have, you should ask yourself if you’re not using too much dependencies whenever you run into conflicts, as this is in general a good indicator. See the link to a blog post about this in #5.


### “CocoaPods is bad for the community, because it makes it too easy for users to add many dependencies.”

  This is akin to saying “guns kill people”, but everybody knows it’s really people who kill people (and [psychotic bears with machetes](http://www.sebastienmillon.com/Machete-Bear-Art-Print-15-00)). Furthermore, this reasoning applies to basically any means of fetching code (e.g. git) and as such is not a discussion worth having.

  What _is_ worth discussing, however, is informing the user to be responsible. Ironically enough, the original author of CocoaPods is convinced using a lot of dependencies is a really bad idea. For practical advice on how to deal with this, you should read [this blog post](http://www.fngtps.com/2013/a-quick-note-on-minimal-dependencies-in-ruby-on-rails/) by [Manfred Stienstra](http://twitter.com/manfreds).


### “CocoaPods uses workspaces, which are considered user data. Why does it not use normal sub-projects?”

  Starting from Xcode 4, [Apple introduced workspaces for this very purpose](http://developer.apple.com/library/ios/#featuredarticles/XcodeConcepts/Concept-Workspace.html).

  Since then, they have also added workspace files to each xcodeproj document, leading people to believe that a workspace is user data only. This is simply incorrect and you should **not** ignore workspace documents any longer, if you were doing so.

  Note that CocoaPods itself does not require the use of a workspace. If you prefer to use sub-projects, you can do so by running `pod install --no-integrate`, which will leave integration into your project up to you as you see fit.


### “Why do I have to install Ruby to use CocoaPods?”

  You don’t. OS X comes with a Ruby (1.8.7 or 2.0.0) pre-installed in `/usr/bin/ruby` which are our baselines and these should work out of the box.

  If, however, you want a bit more speed, or are using Ruby for other development tasks, you might want to take a look at installing a newer Ruby version through managers like [rbenv](https://github.com/sstephenson/rbenv) or [RVM](https://rvm.io). In this case you will have to install the Xcode command-line tools.


### “CocoaPods has just changed my entire pbxproj, what gives?”

Xcode projects are ‘PList’ documents. Internally, PList documents can be serialised in a number of ways, two of which are the (OpenStep) ASCII format and a XML format. The former has been deprecated and can no longer be written to disk by official APIs such as the CFPropertyList API. While Xcode still uses this deprecated format, we chose to depend on the CFPropertyList API and not implement custom serialisation code for a format that might be removed without notice.

If you make a change to your project Xcode (currently) will overwrite this change and will save the document in its internal extended ASCII PList format. This is the simplest way for us to support saving Xcode projects without trying to replicate Xcode's internals. 
