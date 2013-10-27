---
title: Setting up for Development
description: If you're looking to contribute to the CocoaPods project through feature additions or bug fixes, follow these instructions on setting up your development environment.
order: 2
---

> Create a clone of the CocoaPods source.

```shell
$ git clone git://github.com/CocoaPods/CocoaPods.git
$ cd CocoaPods
```

Update git submodules and install the dependencies. CocoaPods supports Ruby 1.8.7 and newer. Instructions for RVM are provided, but feel free to use whichever tool you prefer.

> If you are using RVM:

```shell
# Create a blank environment for CocoaPods.
$ echo "rvm use --create ruby-1.9.3-p194@cocoapods" > .rvmrc
$ echo ".rvmrc" >> .git/info/exclude

# Reload the rvm config by jumping in and out of your dev folder
# then init & update git submodules and install ruby dependencies using a rake task.
$ cd .. ; cd -   
$ rake bootstrap 
```

> Otherwise:

```shell
# If bundler is not already installed.
$ sudo gem install bundler 

# Init & update git submodules and install ruby dependencies using a rake task.
$ rake bootstrap
```

> Verify that all specs pass and all examples build. (See rake -T for other tasks.)

```shell
$ rake spec
$ rake examples:build
```

> Start kicker, which will run the specs relevant to the files you update.

```shell
$ kicker -c
```

Create your patch, verify all specs still pass and examples still build, and create a [pull request](https://github.com/CocoaPods/CocoaPods/compare).

## Using latest pod version

If you would like to run latest pod command in terminal for you project. 

> You could run it with full path, i.e.

```shell
$HOME/code/CocoaPods/bin/pod install
```

> For convenience you could add the next alias to you .zshrc or .bashrc or similar:

```shell
alias pod-dev='$HOME/code/CocoaPods/bin/pod'
```

Other advanced aliases:

> If you are using RVM and have specific gemset for cocoapods (i.e. with the same name) than you could use next alias:

```shell
alias pod-dev='rvm ruby-1.9.3-p194@cocoapods do $HOME/code/CocoaPods/bin/pod'
```

> If you want to autoload [Pry](https://github.com/pry/pry) and the [Awesome Print](https://github.com/michaeldv/awesome_print) gems set the ```COCOA_PODS_ENV``` environment variable to ```development```. This can be done with an alias like:

```shell
alias pod-dev='COCOA_PODS_ENV=development ~/Documents/GitHub/CocoaPods/bin/pod'
```