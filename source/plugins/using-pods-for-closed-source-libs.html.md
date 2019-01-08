---
title: Packaging Closed Source SDKs
description: Using cocoapods-packager to ship closed source Pods
order: 4
---

## The Problem

You need to write an SDK that is closed source, but you'd like to use dependencies. Due to the limitations of the 
process runtime, you can only have one version of a dependency in an app. If your closed-source SDK happens to include 
the same dependencies as another then your SDK consumers are not going to have a good time.

## The answer

CocoaPods Packager is a `pod` command that takes a Podspec and generates the resulting framework or static library for
you. It has techniques for embedding it's dependencies safely and uses a Podspec as the source of truth for all your 
settings.


```sh
bundle exec pod package ORStackView.podspec
```

To find out more, check out [`cocoapods/cocoapods-packager`](https://github.com/cocoapods/cocoapods-packager).
