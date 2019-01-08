---
title: Pre-compiling dependencies
description: Using cocoapods-binary to pre-compile a set of your pods
order: 2
---

## The Problem

Even though you haven't made any changes to the Pods in your project, Xcode can still re-compile you libraries, even 
when it should not need to do this. For a few small libraries this can be a small irritant, in a large project 
this can be time-consuming and annoying.

## The answer

One solution for this is to not give Xcode the chance to re-compile code. CocoaPods Binary will pre-compile your Pods during 
`pod install`, and then add the binary assets (e.g. `.framework` files) into the generated Xcode projects instead of the source code. 

CocoaPods Binary works by adding a pre-install phase which:

- Pulls out pods which you specify to be pre-compiled
- Compiles those pods
- Switches the Podspecs which used to refer to source code, to refer to the new compiled frameworks

To specify which Pods you want to convert, edit your `Podfile` by appending `:binary => true` to your `pod` definitions.

<pre><code>  plugin 'cocoapods-binary'
  use_frameworks!

  target "HP" do
-      pod "ExpectoPatronum"
+      pod "ExpectoPatronum", :binary => true
  end
</code></pre>

Then run `bundle exec pod install`.

To find out more, check out [`leavez/cocoapods-binary`](https://github.com/leavez/cocoapods-binary).
