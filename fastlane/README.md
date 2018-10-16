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

### prepare_framework_release
```
fastlane prepare_framework_release
```
Prepares the framework for release

This lane should be run from your local machine, and will push a tag to the remote when finished.

 * Verifies the git branch is clean

 * Ensures the lane is running on the master branch

 * Pulls the remote to verify the latest the branch is up to date

 * Updates the version of the info plist path used by the framework

 * Updates the the version of the podspec

 * Commits the changes

 * Pushes the commited branch

 * Creates a tag

 * Pushes the tag

####Example:

```
fastlane prepare_framework_release version:3.0.0
```


### complete_framework_release
```
fastlane complete_framework_release
```
Completes the framework release

This lane should be from a CI machine, after the tests have passed on the tag build. This lane does the following:

 * Verifies the git branch is clean

 * Ensures the lane is running on the master branch

 * Pulls the remote to verify the latest the branch is up to date

 * Generates a changelog for the Github Release

 * Creates a Github Release

 * Builds Carthage Frameworks

 * Uploads Carthage Framework to Github Release

 * Pushes podspec to pod trunk

 * Lints the pod spec to ensure it is valid



----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
