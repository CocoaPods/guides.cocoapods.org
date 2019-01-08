---
title: Optimise CI
description: Using cocoapods-check to reduce work on CI
order: 2
---

## The Problem

`pod install` can take some time to complete, and if you have your `Pods` directory cached - sometimes you don't need to run it again for the current CI run. 

This is the problem that [the Square team](https://github.com/square) addressed with the [plugin CocoaPods Check](https://github.com/square/cocoapods-check). 

## The answer

CocoaPods Check adds a command `pod check`, which will return with an error code of not zero if you need to run `pod install`. This means that you can run:

```sh
bundle exec pod check || bundle exec pod install
```

In your CI instead of just `bundle exec pod install` and you will get faster CI builds.

To find out more, check out [`square/cocoapods-check`](https://github.com/square/cocoapods-check).
