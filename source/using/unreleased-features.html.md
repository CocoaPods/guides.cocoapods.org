---
title: Using Unreleased Features
description: Instructions to use CocoaPods from a feature branch or a Work-in-progress fork
ignore: true
order: 0
thanks: "Sachin Palewar"
external links:
-
  "CocoaPods Is Ready for Swift": http://swiftwala.com/cocoapods-is-ready-for-swift/

--- 

## Using Unreleased Features

There may be times when you may want to test an upcoming feature in CocoaPods. At times code for such features may be already available in a 'feature branch'. This document is based on an existing Pull Request which can/will change with time, as such it may be out of date slightly.

The technique to run a branch version of CocoaPods is:

* Clone a copy of CocoaPods locally.
* Check out the version to the branch you want.
* Run `bundle install` to get CocoaPods set up.
* Use the full path to the new `pod` binary, instead of the one installed via rubygems.

Then when you want to update you go back to that local install and run `git pull`, then `bundle install` again.

## Real world walk-through

Let's use [@mrackwitz's](http://twitter.com/mrackwitz) Swift [Pull Request CocoaPods#2835](https://github.com/CocoaPods/CocoaPods/pull/2835) as a example.

#### Clone a local copy

By looking at the subheading `mrackwitz  wants to merge 85 commits into master from swift` you can infer that this pull request comes from a branch on the CocoaPods repo. If it looked like [Pull Request CocoaPods#2880](https://github.com/CocoaPods/CocoaPods/pull/2880) (`[...] CocoaPods:master from samdmarshall:xclegacy-build-setting-build-dir-fix`) then you could see that it comes from the [samdmarshall](https://github.com/samdmarshall/cocoapods/tree/xclegacy-build-setting-build-dir-fix) fork and you would need to clone from that repo.

> Cloning a local copy 

``` bash
cd projects/cocoapods/
git clone https://github.com/CocoaPods/CocoaPods.git
```

#### Check out the branch, and run `bundle install`

> This is easy for our pull request, we first need to `cd` in to the new folder :

```
cd CocoaPods
git checkout swift
bundle install
```

#### Using the new version as your `pod` command

The new `pod` command lives in the git repo you have just cloned. It can be found in the `bin` folder.

> To get the full path of the command for CocoaPods run:

``` bash
echo $(pwd)"/bin/pod"
# e.g. /Users/orta/spiel/ruby/CocoaPods/bin/pod
```

This is the command you can use to run the branch version of CocoaPods:

``` bash
cd ~/projects/dev/eidolon
/Users/orta/spiel/ruby/CocoaPods/bin/pod install
```

#### Aliasing the command

The terminal supports using aliases as a way of reducing the length of commands. The default terminal shell is called bash, if you'd like to learn how to set a bash alias I would recommend reading [this StackOverflow](http://stackoverflow.com/questions/8967843/how-do-i-create-a-bash-alias). You can create an alias like `spod` that uses this folder:

``` bash
alias spod='/Users/orta/spiel/ruby/CocoaPods/bin/pod'
```

This means you can instead run `spod install` to use your custom version of CocoaPods.


#### Alternative options

Another option is to use [Bundler](http://bundler.io) ( CocoaPods for ruby projects ) to maintain your own fork/branches, this is a better option if you are in a team and want to ensure consistency within developers. See _CocoaPods Is Ready for Swift_ for an example of how to do this.