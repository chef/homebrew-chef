# Homebrew-Chef
[![Build status](https://badge.buildkite.com/aca5f240e299768ef33c8ccd90c4f713d56e811e9af8d0300c.svg?branch=master)](https://buildkite.com/chef-oss/chef-homebrew-chef-master-verify)

**Umbrella Project**: [Chef Foundation](https://github.com/chef/chef-oss-practices/blob/master/projects/chef-foundation.md)

**Project State**: [Active](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md#active)

**Issues [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md)**: 14 days

**Pull Request [Response Time Maximum](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md)**: 14 days

For users on macOS, Chef maintains a [Homebrew](https://brew.sh/) Cask that makes it easy to install and keep up-to-date Chef Infra Client and Chef InSpec.

## Quick Install

```
brew cask install chef/chef/inspec

# or 

brew cask install chef/chef/chef-infra-client
```

## Staying Up-To-Date

Packages can be easily upgraded after being installed via Homebrew

Upgrading one package:

```
brew cask upgrade chef-infra-client
```

Upgrading all of your Casks:

```
brew cask upgrade
```
