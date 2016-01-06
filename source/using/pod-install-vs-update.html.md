---
title: pod install vs. pod update
description: Explains the difference between pod install and pod update and when to use each
order: 1
---

## Introduction

Many people starting with CocoaPods seem to think `pod install` is only used the first time you setup a project using CocoaPods and `pod update` is used afterwards. **But that's not the case at all**.

The aim of this guide is to explain when you should use `pod install` and when you should use `pod update`.

#### _TL;DR:_

* Use `pod install` to *install new pods* in your project. **Even if you already have a `Podfile` and ran `pod install` before**; so even if you are just adding/removing pods to a project already using CocoaPods.
* Use `pod update PODNAME` only when you want to *update a pod* to a newer version.

## Detailed presentation of the commands

> Note: the vocabulary of `install` vs. `update` is not actually specific to CocoaPods: it is inspired by a lot of other dependency managers like `bundler`, `rubygem` and `homebrew` which have similar commands, with the exact same behavior and intents as the one described in this document.

### pod install

This is to be used every time you edit your `Podfile` to add a new pod to it (or remove one from it).

* Every time the `pod install` command is run — and downloads and install new pods — it writes the version it has installed, for each pods, in the `Podfile.lock` file. This file keeps track of the installed version of each pod and to *lock* those versions.
* When you run `pod install`, it only resolve dependencies for pods that are **not** already listed in the Podfile.lock.
  * For pods listed in the `Podfile.lock`, it downloads the explicit version listed in the `Podfile.lock` without trying to check if a newer version is available
  * For pods not listed in the `Podfile.lock` yet, it searches for the version that matches what is described in the `Podfile` (like in `pod 'MyPod', '~>1.2'`)

### pod outdated

When you run `pod outdated`, CocoaPods will list all pods which have newer versions than the ones listed in the `Podfile.lock` (the versions currently installed for each pod) and which could be updated (as long as it matches the restrictions like `pod 'MyPod', '~>x.y'` set in your `Podfile`)

### pod update

When you run `pod update PODNAME`, CocoaPods will try to find an updated version of the pod `PODNAME`, without taking into account the version listed in `Podfile.lock`. It will update the pod to the latest version possible (as long as it matches the version restrictions in your `Podfile`).

If you run `pod update` with no pod name, CocoaPods will update every pod listed in your `Podfile` to the latest version possible.

## Intended usage

With `pod update PODNAME`, you will be able to only **update** a specific pod (check if a new version exists and update the pod accordingly). As opposed to `pod install` which won't try to update versions of pods already installed.

When you add a pod to your `Podfile`, you should run `pod install`, not `pod update` — to install this new pod without risking to update existing pod in the same process.

You will only use `pod update` when you want to update the version of a specific pod (or all the pods).

## Scenario Example

If [your policy is not to commit the `Pods` folder into your shared repository](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control), don't forget to at least commit & push your `Podfile.lock` file. This file must always be pushed to the repository.

#### Stage 1: User create the project

_user1_ creates a project and wants to use pods `A`,`B`,`C`. They create a `Podfile` with those pods and run `pod install`.

This will install pods `A`,`B`,`C` say all in version `1.0`, because they are all in version `1.0` at that time.

The `Podfile.lock` will keep track of that and note that `A`,`B` and `C` are each installed as version `1.0`.

> _Incidentally, because that's the first time they run `pod install` and the `Pods.xcodeproj` project doesn't exist yet, the command will also create the `Pods.xcodeproj` and the `.xcworkspace`, but that's a side effect of the command, not its primary role._

#### Stage 2: User1 adds a new pod

Later, _user1_ wants to add a pod `D` into its `Podfile`.

**They should thus run `pod install`** afterwards, so that even if the maintener of pod `B` released a version `2.0` of their pod since the first execution of `pod install`, the project will keep using version `1.0` — because they only want to add pod `D` without risking to update pod `B` unexpectedly.

#### Stage 3: User2 joins the project

Then _user2_, who never worked on the project before, joins the team. They clone the repository then use `pod install`.

The content of `Podfile.lock` (which must be committed onto the git repo) will guaranty them they will get the exact same pods, with the exact same versions that _user1_ was using. Even if a version `2.0` of pod `C` is now available — but you didn't have the occasion to test the project's code with this version `2.0` yet —, _user2_ will get the pod `C` in version `1.0`. Because that's what is registered is `Podfile.lock`. pod `C` is *locked* to version `1.0` by the `Podfile.lock` (hence the name of this file)

#### Stage 4: Checking for new versions of a pod

Later, _user1_ wants to check if any updates are available for the pods. They run `pod outdated` which will tell him that both pods `B` and `C` have a version `2.0` released.

_user1_ decides they want to update pod `B`, but not pod `C`; so they will **run `pod update B`**  which will install `B` in version `2.0` (and update the `Podfile.lock` accordingly) **but** will keep pod `C` in version `1.0`.