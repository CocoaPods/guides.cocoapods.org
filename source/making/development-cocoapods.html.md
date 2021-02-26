---
title: Development Pods
description: How to reference a local checkout of a Pod's repository while working on modifications to it.
order: 4

---

If you yourself are the author of a Pod and you develop it in concert with an app, you
often find yourself wanting to make changes to the Pod while it is installed into the app,
to be able to try out your changes right there.

Since CocoaPods assumes it has sole control of the Pods it checks out, you should not
change the CocoaPod directly, as that would mean that CocoaPods might discard your
changes and you could lose your changes on a thoughtless `pod update`.

Instead, install your pod as a development pod.

Where you usually refer to your (non-development) Pod as

    pod 'AwesomeView', '~> 1.42.0'

you now instead specify it in your Podfile as

    pod 'AwesomeView', :path => '/Users/yourusername/path/to/pod/repo/AwesomeView'

So it references your local checkout of your pod's repository. Then go into your _project_
directory and update only that Pod:

```shell
$ cd /path/to/project/folder
$ pod update AwesomeView
```

Now you should see a `Development Pods` group in your `Pods` project, containing a group
showing all your Pod's source files, for you to conveniently edit. These are the files
where you checked them out (not write-protected copies like usual checkouts of Pods), so
you can safely edit them and push your changes to your repository just as you normally
would without CocoaPods.
