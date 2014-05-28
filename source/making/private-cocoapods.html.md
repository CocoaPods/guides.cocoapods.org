---
title: Private Pods
description: How to setup a private Podspec repo for maintaining internal libraries.
order: 3
external links:
-
  "Using CocoaPods to Modularize a Big iOS App by @aroldan": http://dev.hubspot.com/blog/architecting-a-large-ios-app-with-cocoapods

---

CocoaPods is a great tool not only for adding open source code to your project, but also for sharing components across projects. You can use a private Spec Repo to do this.

There are a few steps to getting a private pods setup for your project; creating a private repository for them, letting CocoaPods know where to find it and adding the podspecs to the repository.

###1. Create a Private Spec Repo
To work with your collection of private pods, we suggest creating your own Spec repo. If you plan on forking a library that is already part of the Master Spec repo, for now we suggest choosing a name that starts with a letter before `M` (due to spec repos loading in alphabetical order, see [#982](https://github.com/CocoaPods/CocoaPods/issues/982)).

**You do not need to fork the CocoaPods/Specs Master repo.** Make sure that everyone on your team has access to this repo, but it does not need to be public.

> The structure of your repo should mirror this:

```
.
├── Specs
    └── [SPEC_NAME]
        └── [VERSION]
            └── [SPEC_NAME].podspec
```

###2. Add your Private Repo to your CocoaPods installation
```shell
$ pod repo add REPO_NAME SOURCE_URL
```
<aside>Note: If you plan on creating pods locally, you should have push access to SOURCE_URL</aside>

> To check if your installation is successful and ready to go:

```shell
$ cd ~/.cocoapods/repos/REPO_NAME
$ pod repo lint .
```

###3. Add your Podspec to your repo

> Make sure you've tagged and versioned your source, then run:

```shell
$ pod repo push REPO_NAME SPEC_NAME.podspec
```

This will run `pod spec lint`, and take care of all the little details for setting up the spec in your private repo.

##That's it!
Your private pod is ready to be used in a Podfile.

## How to remove a Private Repo

`pod repo remove [name]`
