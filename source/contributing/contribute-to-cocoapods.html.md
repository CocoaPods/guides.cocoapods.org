---
title: How to Contribute
description: CocoaPods is fully open-sourced, so it depends on community contributions to get better. If you're looking to start working on CocoaPods, this is the place to start.
---

# Contributing Code

##The Development Workflow

The standard development on CocoaPods happens like so:

- Fork [`CocoaPods/CocoaPods`](https://github.com/CocoaPods/CocoaPods/)
- Pickup an [Issue ](https://github.com/CocoaPods/CocoaPods/issues?page=1&state=open). See issue clarifications [explained below](#issue-clarifications)
- Check the [CONTRIBUTING](https://github.com/CocoaPods/CocoaPods/blob/master/CONTRIBUTING.md) requirements.
- Make a [pull request](#making-the-pull-request).

### Picking Up Issues

####Issue Classifications

- **Defect:** These are known bugs. The issue should also contain steps to reproduce. Feel free to fix these and submit a pull request.
- **Enhancement:** These are planned enhancements that have not been picked up yet. If you would like to work on one, please add a comment that you are doing so.
- **Discussion:** These are issues that can be non-issues, and encompass best practices, or plans for the future.
- **Quick:** These are small issues, that should be able to be fixed quickly. Normally these issues don't stay around for very long.
- **To check:** These issues may not be reproduceable, or have not been vetted by a team member.
- **Workaround known:** These issues have had their solutions discussed, but have yet to be implemented.

####Making the Pull Request

Before submitting your pull request, please do the following:

1. Run `rake spec` and make sure all the tests pass. If you are adding new commands or features, they must include tests. If you are changing functionality, update the tests if you need to.
2. Add a note to the `changelog` describing what you changed.
3. Make your pull request. If it is related to an issue, add a link to the issue in the description.

##Code Style

CocoaPods favors small methods and many classes as convention. It is encouraged that methods are as small as possible, both for code reuse, and for ease of reading.

Take [`install!`](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/installer.rb#L85) from the `Installer` class of the CocoaPods gem:

```ruby
def install!
  resolve_dependencies
  download_dependencies
  generate_pods_project
  integrate_user_project if config.integrate_targets?
end
```
Almost all classes are namespaced. For example, `Installer` calls upon `Installer::TargetInstaller` and `Installer::PodSourceInstaller` to get its work done. Source files for these should reside within the named folder.

Method and variable naming should be very explicit. For example `PodSourceInstaller#download_source` is responsible for downloading the sources. Please avoid method and variable names that are generic, i.e. `var`, `a` etc, unless used in a block.

All methods should be documented and grouped as explained in the documentation section.

###Tests

CocoaPods has an extensive test suite. No code is accepted to `master` where the tests do not pass. All test files can be found in the `spec` repository.

The tests for CocoaPods are written in Bacon and separated into Unit, Integration, and Functional test. To run the full test suite:

```shell
$ bundle exec rake
```

To run a single test suite:

```shell
$ bundle exec rake spec:functional
```

Occasionally, the fixtures used for functional tests need to be rebuilt. This is especially true when changes are made to the file structure of the Pods directory. To update these fixtures, run:

```shell
$ bundle exec rake spec:rebuild_integration_fixtures
```

###Documentation

All methods and attributes must be documented. As part of the release process for CocoaPods, documentation is generated from source and posted online. [Rdoc](http://docs.seattlerb.org/rdoc/) is used for generating this documentation.

Documentation should be brief, but explanatory. All paramaters and return values need to be explained. Notes and examples, while not required, are encouraged. Take a look at this method from the [Project](https://github.com/CocoaPods/CocoaPods/blob/master/lib/cocoapods/project.rb#L42) class:

```ruby
# @return [Pathname] Returns the relative path from the project root.
#
# @param  [Pathname] path
#         The path that needs to be converted to the relative format.
#
# @note   If the two absolute paths don't share the same root directory an
#         extra `../` is added to the result of
#         {Pathname#relative_path_from}.
#
# @example
#
#   path = Pathname.new('/Users/dir')
#   @sandbox.root #=> Pathname('/tmp/CocoaPods/Lint/Pods')
#
#   @sandbox.relativize(path) #=> '../../../../Users/dir'
#   @sandbox.relativize(path) #=> '../../../../../Users/dir'
#
```

