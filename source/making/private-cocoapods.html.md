---
title: Private Pods
description: How to setup private pods, a private specs repo, etc.
---

##Private Pods

CocoaPods is a great tool not only for adding open source code to your project, but also for sharing components across projects. Creating and using private pods is essential for this.  

There are a few steps to getting a private pod setup in your project. This is the recommended setup for developing and maintaining private pods.

###1. Create a Private Spec Repo
To work with your collection of private pods, we suggest creating your own Spec repo. If you plan on forking a library that is already part of the Master Spec repo, we suggest choosing a name that starts with a letter before `M` (due to spec repos loading in alphabetical order, see [#1158](https://github.com/CocoaPods/CocoaPods/issues/1158)).  

**You do not need to fork the CococaPods/Specs Master repo.** Make sure that everyone on your team has access to this repo, but it does not need to be public.  

The structure of your repo should mirror this:

```
.
├── Specs
    └── #{SPEC_NAME}
        └── #{VERSION}
            └── #{SPEC_NAME}.podspec
```

###2. Add your Private Repo to your CocoaPods installation
This is as easy as running:

```
$ pod repo add NAME SOURCE_URL
```
*Note: If you plan on creating pods locally, SOURCE_URL should have push access*

To check if your installation is successful and ready to go:

```
$ cd ~/.cocoapods/NAME
$ pod repo lint .
```

###3. Add your Podspec to your repo
Make sure you've tagged and versioned your source, then run:

```
$ pod push NAME SPEC_NAME.podspec
```

This will run `pod spec lint`, and take care of all the little details for setting up the spec in your private repo.

##That's it!
Your private pod is ready to be used in a Podfile.