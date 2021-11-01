---
title: Private Pods
description: How to setup a private Podspec repo for maintaining internal libraries.
order: 5
external links:
-
  "Using CocoaPods to Modularise a Big iOS App by @aroldan": http://dev.hubspot.com/blog/architecting-a-large-ios-app-with-cocoapods

---

CocoaPods is a great tool not only for adding open source code to your project, but also for sharing components across projects. You can use a private Spec Repo to do this.

There are a few steps to getting a private pods setup for your project; creating a private repository for them, letting CocoaPods know where to find it and adding the podspecs to the repository.

###1. Create a Private Spec Repo
To work with your collection of private pods, we suggest creating your own Spec repo. This should be in a location that is accessible to all who will use the repo.

**You do not need to fork the CocoaPods/Specs Master repo.** Make sure that everyone on your team has access to this repo, but it does not need to be public.

###2. Add your Private Spec Repo to your CocoaPods installation
```shell
$ pod repo add REPO_NAME SOURCE_URL
```
<aside>Note: If you plan on creating pods locally, you should have push access to SOURCE_URL</aside>

> To check if your installation is successful and ready to go:

```shell
$ cd ~/.cocoapods/repos/REPO_NAME
$ pod repo lint .
```

###3. Add your Pod's Podspec to your repo

> Make sure you've tagged and versioned your source appropriately, then run:

```shell
$ pod repo push REPO_NAME SPEC_NAME.podspec
```

This will run `pod spec lint`, and take care of all the little details for setting up the spec in your private repo.

> The structure of your repo should mirror this:

```
.
├── Specs
    └── [SPEC_NAME]
        └── [VERSION]
            └── [SPEC_NAME].podspec
```

## That's it!

Your private Pod is ready to be used in a Podfile. You can use the spec
repository with the [`source` directive](/syntax/podfile.html#source)
in your Podfile as shown in the following example:

```ruby
source 'URL_TO_REPOSITORY'
```

## An Example

###1. Create a Private Spec Repo

> Create a repo on your server. This can be achieved on Github or on your own server as follows

```shell
$ cd /opt/git
$ mkdir Specs.git
$ cd Specs.git
$ git init --bare
```

(The rest of this example uses the repo at https://github.com/artsy/Specs)

###2. Add your repo to your CocoaPods installation

> Using the URL of your repo on your server, add your repo using

```shell
$ pod repo add artsy-specs https://github.com/artsy/Specs.git
```

> Check your installation is successful and ready to go:

```shell
$ cd ~/.cocoapods/repos/artsy-specs
$ pod repo lint .
```

###3. Add your Podspec to your repo

>Create your Podspec

```shell
cd ~/Desktop
touch Artsy+OSSUIFonts.podspec
```

> Artsy+OSSUIFonts.podspec should be opened in the text editor of your choice. Typical contents are 

```
Pod::Spec.new do |s|
  s.name             = "Artsy+OSSUIFonts"
  s.version          = "1.1.1"
  s.summary          = "The open source fonts for Artsy apps + UIFont categories."
  s.homepage         = "https://github.com/artsy/Artsy-OSSUIFonts"
  s.license          = 'Code is MIT, then custom font licenses.'
  s.author           = { "Orta" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/artsy/Artsy-OSSUIFonts.git", :tag => s.version }
  s.social_media_url = 'https://twitter.com/artsy'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*'

  s.frameworks = 'UIKit', 'CoreText'
  s.module_name = 'Artsy_UIFonts'
end
```
> Save your Podspec and add to the repo

```shell
pod repo push artsy-specs ~/Desktop/Artsy+OSSUIFonts.podspec
```

> Assuming your Podspec validates, it will be added to the repo.  The repo will now look like this

```
.
├── Specs
    └── Artsy+OSSUIFonts
        └── 1.1.1
            └── Artsy+OSSUIFonts.podspec
```

> See this [Podfile](https://github.com/artsy/eigen/blob/eae3a631d35da68af7be2f3296235d41cce6fe1b/Podfile) for an example of how the repo URL is included

## How to remove a Private Repo

`pod repo remove [name]`
