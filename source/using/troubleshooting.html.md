---
title: Troubleshooting
description: The solutions to common problems.
order: 4
---

### Installing CocoaPods

* If you are installing on macOS 10.9.0-10.9.2, you may run into an issue when RubyGems tries to install the `json` gem. To fix this follow [these](https://gist.github.com/alloy/62326fcbc5b8ef987c17) instructions.
* After upgrading from macOS 10.8 to 10.9 the installed CocoaPods gem doesn’t work anymore, even after re-installing the gem. To solve this, you might need to uninstall the gem first and then re-install.

         $ gem uninstall cocoapods
         $ gem install cocoapods

* The gem might not be able to compile, to solve this you might need to [symlink GCC](http://www.relaxdiego.com/2012/02/using-gcc-when-xcode-43-is-installed.html).
* If you used an pre release version of Xcode you might need to update the command line tools.
* CocoaPods is not compatible with MacRuby.
* If you get the error "ERROR:  While executing gem ... (Errno::EPERM); Operation not permitted - /usr/bin/fuzzy_match" then try:
         $ sudo gem install -n /usr/local/bin cocoapods

### Using the CocoaPods Project

1. Use the Xcode workspace `<Project>.xcworkspace`, not the Xcode project.

2. If something doesn’t seem to work, first of all ensure that you are not completely overriding any options set from the `Pods.xcconfig` file in your project’s build settings. To add values to options from your project’s build settings, prepend the value list with `$(inherited)`.

3. If Xcode can’t find the headers of the dependencies:
   * Check if the pod header files are correctly symlinked in `Pods/Headers` and you are not overriding the `HEADER_SEARCH_PATHS` (see #1).
   * Make sure your project is using the `Pods.xcconfig`. To check this select your project file, then select it in the second pane again and open the `Info` section in the third pane. Under configurations you should select `Pods.xcconfig` for each configurations requiring your installed pods.
   * If Xcode still can’t find them, as a last resort you can prepend your imports, e.g. `#import "Pods/SSZipArchive.h"`.

4. If you're getting errors about unrecognised C compiler command line options, e.g. `cc1obj: error: unrecognised command line option "-Wno-sign-conversion"`:
   * Make sure your project build settings are [configured](https://img.skitch.com/20111120-brfn4mp8qwrju8w8325wphan9h.png) to use "Apple LLVM compiler" (clang)
   * Are you setting the `CC`, `CPP` or `CXX` environment variable, e.g. in your `~/.profile`? This may interfere with the Xcode build process. Remove the environment variable from your `~/.profile`.

5. If Xcode complains when linking, e.g. `Library not found for -lPods`, it doesn't detect the implicit dependencies:
   * Go to Product > Edit Scheme
   * Click on Build
   * Add the `Pods` static library, and make sure it's at the top of the list
   * Clean and build again
   * If that doesn't work, verify that the source for the spec you are trying to include has been pulled from GitHub. Do this by looking in &lt;Project Dir>/Pods/&lt;Name of spec you are trying to include>. If it is empty (it should not be), verify that the ~/.cocoapods/master/&lt;spec>/&lt;spec>.podspec has the correct git hub url in it.
   * If still doesn't work, check your Xcode build locations settings. Go to Preferences -> Locations -> Derived Data -> Advanced and set build location to "Relative to Workspace".

<center> ![Xcode build location settings](https://img.skitch.com/20120426-chmda3m5suhcfrhjge6brjhesk.png) </center>

* If you tried to submit app to App Store, and found that "Product" > "Archive" produce nothing in "Organizer":
    * In Xcode "Build Settings", find "Skip Install". Set the value for "Release" to "NO" on your application target. Build again and it should work.

_Different Xcode versions can have various problems. Ask for help and tell us what version you're using._

### Can I workaround ‘Duplicate Symbol’ errors with static libraries?

This usually occurs when you’re using a closed-source third-party library that includes a common dependency of your application. One brute-force workaround is to remove the dependency from the static library, as described [here](http://atnan.com/blog/2012/01/12/avoiding-duplicate-symbol-errors-during-linking-by-removing-classes-from-static-libraries)

However, in general, the vendor should really prefix any dependencies it includes, so you don’t need to deal with it. When this happens, please contact the vendor and ask them to fix it on their side and use the above method as a temporary workaround.

### I'm getting permission errors while running pod commands

As of CocoaPods 0.32.0 we have removed the ability to run the pod commands as
root to prevent CocoaPods from getting into an inconsistent state when you mix
and match running as root.

If you have ran CocoaPods as root at one stage you may start getting permission
denied errors when performing certain operations. When you come across
permission errors you may need to delete old files which run as root such as
the cache data. You can do this with the following commands.

    $ sudo rm -fr ~/Library/Caches/CocoaPods/
    $ sudo rm -fr ~/.cocoapods/repos/master/

Alongside those global files, there may also be a `Pods` directory in any place
you have a Podfile. If you still receive permission errors you should delete
this directory too, and afterwards run `pod install`.

    $ sudo rm -fr Pods/

### The Fix I want is in master / a branch, but I'm blocked on this right now

There is [a guide for using a version of CocoaPods to try new features](/using/unreleased-features) that are in discussion or in implementation stage.

### I didn't find the solution to my problem!

We have multiple avenues for support, here they are in the order we prefer.

* [Stack Overflow](http://stackoverflow.com/search?q=CocoaPods), get yourself some internet points. This keeps the pressure off the CocoaPods dev team and gives us time to work on the project and not support. One of the advantages of using Stack Overflow is that the answer is then easily accessible for others.

* [CocoaPods Mailing List](http://groups.google.com/group/cocoapods), the mailing list is mainly used for announcements of related projects and for support.

* If your question is regarding a library (to be) distributed through CocoaPods, refer to the [spec repo](https://github.com/CocoaPods/Specs).

### I think this is a bug with CocoaPods

In this case we want to get it on a GitHub issues tracker, we use this to keep track of the development work we have to do.

* **Search tickets before you file a new one.** Add to existing tickets if you have new information about the issue.

* **Only file tickets about the CocoaPods tool itself.** This includes [CocoaPods](https://github.com/CocoaPods/CocoaPods/issues),
  [CocoaPods/Core](https://github.com/CocoaPods/Core/issues), and [Xcodeproj](https://github.com/CocoaPods/Xcodeproj/issues).

* **Keep tickets short but sweet.** Make sure you include all the context needed to solve the issue. Don't overdo it. Great tickets allow us to focus on solving problems instead of discussing them.
