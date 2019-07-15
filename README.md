# Homebrew-Chef
[![Build status](https://badge.buildkite.com/aca5f240e299768ef33c8ccd90c4f713d56e811e9af8d0300c.svg?branch=master)](https://buildkite.com/chef-oss/chef-homebrew-chef-master-verify)

For users on MacOS, Chef maintains a [Homebrew](https://brew.sh/) Cask that makes it easy to install and keep up-to-date ChefDK, Chef InSpec, and Chef Workstation.

## Quick Install

```
brew cask install chef/chef/chefdk

# or

brew cask install chef/chef/inspec

# or

brew cask install chef/chef/chef-workstation
```

## Staying Up-To-Date

Packages can be easily upgraded after being installed via Homebrew

Upgrading one package:

```
brew cask upgrade chefdk
```

Upgrading all of your Casks:

```
brew cask upgrade
```
