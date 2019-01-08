---
title: Keeping Secrets
description: Using cocoapods-keys to keep secrets out of your source
order: 1
---

## The Problem

You want to keep secrets like API access tokens outside of your source code. This is considered a good 
engineering practice in general ([least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)) and 
you may want to have different environments like staging and production.

## The answer

CocoaPods Keys adds a few commands, and uses the installation hooks:

- `bundle exec pod keys set ARKeyName value` - lets you store a value in your computer's keychain 
- `bundle exec pod keys get ARKeyName` - prints out the value from your computer's keychain

Then inside your `Podfile`, add the plugin section. Noting the name of the `project`, the `target` to attach the pod
to, and the keys that you want to use:

```ruby
plugin 'cocoapods-keys',
       project: 'Artsy',
       target: 'Artsy',
       keys: [
         'ArtsyAPIClientSecret',      # Auth for the Artsy API
         'ArtsyAPIClientKey',         #
         'ArtsyFacebookAppID',        # Supporting FB Login
       ]
```

When you run `bundle exec pod install`, CocoaPods Keys will add a new Pod that has all of of your keys embedded inside it.

To find out more, check out [`orta/cocoapods-keys`](https://github.com/orta/cocoapods-keys).
