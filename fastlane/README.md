fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### travis
```
fastlane travis
```

### release_framework
```
fastlane release_framework
```
Releases the framework

This lane should be run from your local machine.

 * Verifies the git branch is clean

 * Ensures the lane is running on the master branch

 * Pulls the remote to verify the latest the branch is up to date

 * Updates the version of the info plist path used by the framework

 * Updates the the version of the podspec

 * Commits the changes

 * Pushes the commited branch

 * Creates a tag

 * Pushes the tag

 * Pushes podspec to pod trunk

####Example:

```
fastlane release_framework version:3.0.0
```



----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
