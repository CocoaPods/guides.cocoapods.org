---
title: Setting up for Development
description: If you're looking to contribute to the CocoaPods project through feature additions or bug fixes, follow these instructions on setting up your development environment.
order: 2
---

CocoaPods is a collection of ruby gems. It is possible to clone them individually and set up a bundler environment for working in CocoaPods. However, for someone new to high-level library development in ruby this comes with a high learning curve. Because of this we will be using this guide to show how to set up using the [CocoaPods Rainforest](https://github.com/CocoaPods/Rainforest).

Rainforest is a git repo that when bootstrapped has submodules of all the required gems for CocoaPods development. Let's clone it:

```shell
$ git clone https://github.com/CocoaPods/Rainforest.git
$ cd Rainforest
```
All of the commands in Rainforest are Rake Tasks. This is a ruby variant of Make Tasks. You can take a look at all the available tasks by running `rake -T` in the terminal.

To get started downloading run:

```shell
$ rake bootstrap
```

This will loop through all the known gems downloading them, and setting up their environments. To verify that everything is set up, run: `CocoaPods/bin/pod --help`.

### Working on CocoaPods

If you're not sure where your changes are going to be, you may way to look at the [Core Components](http://guides.cocoapods.org/contributing/components) to get a sense of where the change will take place.

Once in the correct gem you should verify that all specs pass and all examples build. ( See `rake -T` for other per-gem based tasks. )

```shell
$ rake spec
$ rake examples:build
```

> Start kicker, which will run the specs relevant to the files you update.

```shell
$ kicker -c
```

Create your patch, verify all specs still pass and examples still build, and create a [pull request](https://github.com/CocoaPods/CocoaPods/compare).

### Using latest pod command

If you would like to run latest pod command in terminal for you project.

> You could run it with full path, i.e.

```shell
path/to/Rainforest/CocoaPods/bin/pod install
```

> For convenience you could add the next alias to you .zshrc or .bashrc or similar:

```shell
alias pod-dev='path/to/Rainforest/CocoaPods/bin/pod'
```

Other advanced aliases:

> If you want to autoload [Pry](https://github.com/pry/pry) and the [Awesome Print](https://github.com/michaeldv/awesome_print) gems set the ```COCOA_PODS_ENV``` environment variable to ```development```. This can be done with an alias like:

```shell
alias pod-dev='COCOA_PODS_ENV=development path/to/Rainforest/CocoaPods/bin/pod'
```
