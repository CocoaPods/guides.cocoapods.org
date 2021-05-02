---
title: Setting up for Development
description: If you're looking to contribute to the CocoaPods project through feature additions or bug fixes, follow these instructions on setting up your development environment.
order: 3
---

CocoaPods is a collection of ruby gems. It is possible to clone them individually and set up a bundler environment for working in CocoaPods. However, for someone new to high-level library development in ruby this comes with a high learning curve.

### Working on CocoaPods

If you're not sure where your changes are going to be, you may way to look at the [Core Components](https://guides.cocoapods.org/contributing/components) to get a sense of where the change will take place.

Once in the correct gem you should verify that all specs pass and all examples build. ( See `rake -T` for other per-gem based tasks. )

```shell
$ rake spec
$ rake examples:build
```

Create your patch, verify all specs still pass and examples still build, and create a [pull request](https://github.com/CocoaPods/CocoaPods/compare).

### Using latest pod command

If you would like to run latest pod command in terminal for you project.

> You could run it with full path, i.e.

```shell
path/to/CocoaPods/CocoaPods/bin/pod install
```

> For convenience you could add the next alias to you .zshrc or .bashrc or similar:

```shell
alias pod-dev='path/to/CocoaPods/CocoaPods/bin/pod'
```

Other advanced aliases:

> If you want to autoload [Pry](https://github.com/pry/pry) and the [Awesome Print](https://github.com/awesome-print/awesome_print) gems set the ```COCOA_PODS_ENV``` environment variable to ```development```. This can be done with an alias like:

```shell
alias pod-dev='COCOA_PODS_ENV=development path/to/CocoaPods/CocoaPods/bin/pod'
```
