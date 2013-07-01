---
title: Private Pods
description: How to setup private pods, a private specs repo, etc.
---

##Private Pods

CocoaPods is a great tool not only for adding open source code to your project, but also for sharing components across projects. Creating and using private pods is essential for this.  

There are a few steps to getting a local pod setup in your project. This is the recommended setup for developing and maintaining private pods.

###1. Create a Private Spec Repo
To work with your collection of private pods, we suggest creating your own Spec repo. If you plan on forking a library that is already part of the Master Spec repo, we suggest choosing a name that starts with a letter `A-L` (due to spec repos loading in alphabetical order).  

**You do not need to fork the CococaPods/Specs Master repo.** Make sure that everyone on your team has access to this repo, but it does not need to be public.  

The structure of your repo should mirror this:

```
.
├── Specs
    └── #{SPEC_NAME}
        └── #{VERSION}
            └── #{SPEC_NAME}.podspec
```
###2. Add your Podspec to your repo
Make sure you've tagged and versioned your source, and that a matching `.podspec` is in the root of the project.

###3. Add your Private Repo to your CocoaPods installation
This is as easy as running:

```
$ pod repo add NAME SOURCE_URL
```

##That's it!
Your private pod is ready to be used in a Podfile.