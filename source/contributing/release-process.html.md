---
title: Release Process
description: This describes the CocoaPods release process
---
# Release Process

We should strive for a fast release cycle, following [‘semantic versioning’](http://semver.org). The only difference being that since we are not yet passed version 1.0.0, we don’t increase the major version when an API change is introduced.

### When a release should be made

* After every ‘session’ of bug fixes. This should increase the ‘patch’ version: `x.x.PATCH`
* After every ‘session’ of feature additions. This should increase the ‘minor’ version and set the patch version to zero: `x.MINOR.0`

### Where the work should occur

**‘master’ branch**

This branch is where all work for the next release should be merged. These should be either fixes, small features, or signed-off big features.

**‘feature’ branches**

For a ‘not so small feature’ a separate branch should be created, named after the feature. This branch should branch-off from the ‘master’ branch, to which it eventually will be merged.

##Pull Requests

If you would like to develop on the CocoaPods gems, you need to fork the main repo, work off of your fork, then create a pull request.

Pull requests will be looked over by at least one core team member. Comments will generally be made on everything from code style, documentation, test coverage, and architecture. Every pull request is run through a build on Travis CI and Coveralls.

Tests must pass in order for your pull request to be merged. For new functionality, tests must be added. For the removal of functionality, or significant refactoring, tests can be removed. Make sure to note this in your commit messages, or in the pull request description.

Lastly, make sure to update the `CHANGELOG` with an appropriate message.