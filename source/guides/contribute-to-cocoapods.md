## How can I contribute?

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



**TODO:**

- Code Style
- Documentation Style

## What are the main components?

### CocoaPods
The CocoaPods gem which includes the command line support and the installer.

### Cocoapods-core
The CocoaPods-Core gem provides support to work with the models of CocoaPods.

### Xcodeproj
Xcodeproj lets you create and modify Xcode projects from Ruby. Script boring management tasks or build Xcode-friendly libraries. Also includes support for Xcode workspaces (.xcworkspace) and configuration files (.xcconfig).

### Cocoapods-downloader
A small library that provides downloaders for various source types (HTTP/SVN/Git/Mercurial).

### CLAide
I was born out of a need for a simple option and command parser, while still providing an API that allows you to quickly create a full featured command-line interface.