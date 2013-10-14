---
title: Troubleshooting
description: The solutions to common problems
---
### Troubleshooting

- The gem might not be able to compile, to solve this you might need to [symlink
  GCC](http://www.relaxdiego.com/2012/02/using-gcc-when-xcode-43-is-installed.html).

- If you used an pre release version of Xcode you might need to update the
  command line tools.

- CocoaPods is not compatible with MacRuby.

1. If something doesn’t seem to work, first of all ensure that you are not completely overriding any options set from the `Pods.xcconfig` file in your project’s build settings. To add values to options from your project’s build settings, prepend the value list with `$(inherited)`.

2. If Xcode can’t find the headers of the dependencies:
   * Check if the pod header files are correctly symlinked in `Pods/Headers` and you are not overriding the `HEADER_SEARCH_PATHS` (see #1).
   * Make sure your project is using the `Pods.xcconfig`. To check this select your project file, then select it in the second pane again and open the `Info` section in the third pane. Under configurations you should select `Pods.xcconfig` for each configurations requiring your installed pods.
   * If Xcode still can’t find them, as a last resort you can prepend your imports, e.g. `#import "Pods/SSZipArchive.h"`.

3. If you're getting errors about unrecognized C compiler command line options, e.g. `cc1obj: error: unrecognized command line option "-Wno-sign-conversion"`:
   * Make sure your project build settings are [configured](https://img.skitch.com/20111120-brfn4mp8qwrju8w8325wphan9h.png) to use "Apple LLVM compiler" (clang)
   * Are you setting the `CC`, `CPP` or `CXX` environment variable, e.g. in your `~/.profile`? This may interfere with the Xcode build process. Remove the environment variable from your `~/.profile`.

4. If Xcode complains when linking, e.g. `Library not found for -lPods`, it doesn't detect the implicit dependencies:
   * Go to Product > Edit Scheme
   * Click on Build
   * Add the `Pods` static library, and make sure it's at the top of the list
   * Clean and build again
   * If that doesn't work, verify that the source for the spec you are trying to include has been pulled from github. Do this by looking in &lt;Project Dir>/Pods/&lt;Name of spec you are trying to include>. If it is empty (it should not be), verify that the ~/.cocoapods/master/&lt;spec>/&lt;spec>.podspec has the correct git hub url in it.
   * If still doesn't work, check your XCode build locations settings. Go to Preferences -> Locations -> Derived Data -> Advanced and set build location to "Relative to Workspace".

![Xcode build location settings](https://img.skitch.com/20120426-chmda3m5suhcfrhjge6brjhesk.png)

* If you tried to submit app to App Store, and found that "Product" > "Archive" produce nothing in "Organizer":
    * In Xcode "Build Settings", find "Skip Install". Set the value for "Release" to "NO" on your application target. Build again and it should work. 

_Different Xcode versions can have various problems. Ask for help and tell us what version you're using._
