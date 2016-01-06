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

> Note: the vocabulary of `install` vs. `update` is not actually specific to CocoaPods. It is inspired by a lot of other dependency managers like `bundler`, `rubygem` or PHP's `composer`, which have similar commands, with the exact same behavior and intents as the one described in this document.

### `pod install`

This is to be used every time you edit your `Podfile` to add a new pod to it (or remove one from it).

* Every time the `pod install` command is run — and downloads and install new pods — it writes the version it has installed, for each pods, in the `Podfile.lock` file. This file keeps track of the installed version of each pod and *locks* those versions.
* When you run `pod install`, it only resolve dependencies for pods that are **not** already listed in the Podfile.lock.
  * For pods listed in the `Podfile.lock`, it downloads the explicit version listed in the `Podfile.lock` without trying to check if a newer version is available
  * For pods not listed in the `Podfile.lock` yet, it searches for the version that matches what is described in the `Podfile` (like in `pod 'MyPod', '~>1.2'`)

### `pod outdated`

When you run `pod outdated`, CocoaPods will list all pods which have newer versions than the ones listed in the `Podfile.lock` (the versions currently installed for each pod) and which could be updated (as long as it matches the restrictions like `pod 'MyPod', '~>x.y'` set in your `Podfile`)

### `pod update`

When you run `pod update PODNAME`, CocoaPods will try to find an updated version of the pod `PODNAME`, without taking into account the version listed in `Podfile.lock`. It will update the pod to the latest version possible (as long as it matches the version restrictions in your `Podfile`).

If you run `pod update` with no pod name, CocoaPods will update every pod listed in your `Podfile` to the latest version possible.

## Intended usage

With `pod update PODNAME`, you will be able to only **update** a specific pod (check if a new version exists and update the pod accordingly). As opposed to `pod install` which won't try to update versions of pods already installed.

When you add a pod to your `Podfile`, you should run `pod install`, not `pod update` — to install this new pod without risking to update existing pod in the same process.

You will only use `pod update` when you want to update the version of a specific pod (or all the pods).

## Commit your Podfile.lock

As an reminder, even if [your policy is not to commit the `Pods` folder into your shared repository](https://guides.cocoapods.org/using/using-cocoapods.html#should-i-check-the-pods-directory-into-source-control), **you should always commit & push your `Podfile.lock` file**.

_Otherwise, it would break the whole logic explained above about `pod install` being able to lock the installed versions of your pods._

## Scenario Example

Here is a scenario example to illustrate the various use case one might encounter during the life of a project.

#### Stage 1: User creates the project

_user1_ creates a project and wants to use pods `A`,`B`,`C`. They create a `Podfile` with those pods, and run `pod install`.

This will install pods `A`,`B`,`C`, which we'll say are all in version `1.0`.

The `Podfile.lock` will keep track of that and note that `A`,`B` and `C` are each installed as version `1.0`.

> _Incidentally, because that's the first time they run `pod install` and the `Pods.xcodeproj` project doesn't exist yet, the command will also create the `Pods.xcodeproj` and the `.xcworkspace`, but that's a side effect of the command, not its primary role._

#### Stage 2: User1 adds a new pod

Later, _user1_ wants to add a pod `D` into its `Podfile`.

**They should thus run `pod install`** afterwards, so that even if the maintener of pod `B` released a version `2.0` of their pod since the first execution of `pod install`, the project will keep using version `1.0` — because they only want to add pod `D`, without risking an unexpected update to pod `B`.

> _That's where some people get it wrong, because they use `pod update` here — probably thinking this as "I want to update my *project* with new pods"? — instead of using `pod install` — to install new pods in the project._

#### Stage 3: User2 joins the project

Then _user2_, who never worked on the project before, joins the team. They clone the repository then use `pod install`.

The contents of `Podfile.lock` (which must be committed onto the git repo) will guarantee they will get the exact same pods, with the exact same versions that _user1_ was using.

Even if a version `2.0` of pod `C` is now available, _user2_ will get the pod `C` in version `1.0`. Because that's what is registered is `Podfile.lock`. pod `C` is *locked* to version `1.0` by the `Podfile.lock` (hence the name of this file).

#### Stage 4: Checking for new versions of a pod

Later, _user1_ wants to check if any updates are available for the pods. They run `pod outdated` which will tell them that both pods `B` and `C` have a version `2.0` released.

_user1_ decides they want to update pod `B`, but not pod `C`; so they will **run `pod update B`**  which will install `B` in version `2.0` (and update the `Podfile.lock` accordingly) **but** will keep pod `C` in version `1.0`.

## Using exact versions in the `Podfile` is not enough

Some people think that by specifying exact versions of their pods in their `Podfile`, like `pod 'A', '1.0'` is enough to guarantee that every user will have the same version as other people on the team.

Then they might even use `pod update` even when just adding a new pod, thinking it would never risk to update other pods because they are fixed to a specific version in the `Podfile`.

But in fact, **that is not enough to guarantee that _user1_ and _user2_ in our above scenario will always get the exact same version of all their pods**.

The typical example is if the pod `A` has a dependency on pod `A2`. Then using `pod 'A', '1.0'` in your `Podfile` will indeed force _user1_ and _user2_ to both always use version `1.0` of the pod `A`, but:

* _user1_ might end up with pod `A2` in version `3.4` (because that was `A2`'s latest version at that time)
* while when _user2_ runs `pod install` when joining the project later, they might get pod `A2` in version `3.5` (because the maintener of `A2` might have released a new version in the meantime).

That's why the only way to ensure every team member work with the same versions of all the pod on each's computer is to use the `Podfile.lock` and properly use `pod install` vs. `pod update`.