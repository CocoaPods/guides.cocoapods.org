---
title: Core Components
description: These are the core components that make up the CocoaPods gem
order: 0
---
## What are the main components?

To ensure that CocoaPods has a clean and easily accessible code-base we split the work among a collection of ruby gems. These work together to bring the `pod` command to life.

### [CocoaPods](http://github.com/CocoaPods/CocoaPods)
The CocoaPods gem which includes the command line support and the installer. This handles all of the user interactions for CocoaPods.

### [Cocoapods-core](http://github.com/CocoaPods/Core)
The CocoaPods-Core gem provides support to work with the models of CocoaPods, for example the Podspecs or the Podfile.

### [Xcodeproj](http://github.com/CocoaPods/Xcodeproj)
The Xcodeproj gem lets you create and modify Xcode projects from Ruby. Script boring management tasks or build Xcode-friendly libraries. Also includes support for Xcode workspaces (`.xcworkspace`) and configuration files (`.xcconfig`).

### [Cocoapods-downloader](http://github.com/CocoaPods/CocoaPods-downloader)
The Cocoapods-downloader gem is a small library that provides downloaders for various source control types (HTTP/SVN/Git/Mercurial). It can deal with tags, commits, revisions, branches, extracting files from zips and almost anything these source control system would use.

### [CLAide](http://github.com/CocoaPods/CLAide)
The CLAide gem is a simple command line parser, which provides an API that allows you to quickly create a full featured command-line interface.
