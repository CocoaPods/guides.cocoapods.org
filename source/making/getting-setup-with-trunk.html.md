---
title: Getting setup with Trunk
order: 2
description: Instructions for creating a CocoaPods user account

---

## CocoaPods Trunk

CocoaPods Trunk is an authentication and CocoaPods API service. To publish new or updated libraries to CocoaPods for public release you will need to be registered with Trunk and have a valid Trunk session on your current device. You can read about Trunk's history and development on [the blog](https://blog.cocoapods.org/CocoaPods-Trunk/), and about [private pods](private-cocoapods.html) for yourself or your team.

CocoaPods Trunk is available starting with CocoaPods 0.33. A collection of commands under `pod trunk` automate the deployment and management of your Podspecs. At any time you can run `pod trunk [command] --help` to see inline help.

### Getting started

First sign up for an account with your email address. This begins a session on your current device.

We recommend including a description with your session to give some context when you list your sessions later. For example:

```
$ pod trunk register orta@cocoapods.org 'Orta Therox' --description='macbook air'
```

You must click a link in an email Trunk sends you to verify the connection between your Trunk account and the current computer. You can list your sessions by running `pod trunk me`.

Trunk accounts do not have passwords, only per-computer session tokens.

### Deploying a library

`pod trunk push [NAME.podspec]` will deploy your Podspec to Trunk and make it publicly available. You can also deploy Podspecs to your own private specs repo with `pod repo push REPO [NAME.podspec]`.

Deploying with `push`:

 * Lints your Podspec locally. You can lint at any time with `pod spec lint [NAME.podspec]`
 * A successful lint pushes your Podspec to Trunk or your private specs repo
 * Trunk will publish a canonical JSON representation of your Podspec

Trunk will also post a web hook to other services alerting them of a new CocoaPod, for example [CocoaDocs.org](http://cocoadocs.org) and [@CocoaPodsFeed](https://twitter.com/cocoapodsfeed).

### Adding other people as contributors

The first person to push a Podspec version to Trunk can add other maintainers. For example, to add `kyle@cocoapods.org` to the library `ARAnalytics`:

```
$ pod trunk add-owner ARAnalytics kyle@cocoapods.org
```

This will then list all the known library owners. Note: they need to already have registered an account set up on trunk in order for you to add them to a library.

### Claiming an existing library

If you want to claim a library that someone has already claimed, then you can use [our Claims form](https://trunk.cocoapods.org/disputes) to say that you are the owner or maintainer of a collection of libraries. Any issues regarding ownership of libraries will be arbitrated by the CocoaPods dev team.
