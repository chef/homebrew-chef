#!/bin/sh

# This bumps the version in the ENV var 'VERSION' on the project specified
# It fetches the sha256 via omnitruck api

set -e

# make sure a product was passed into this script
if [ -z ${1+x} ]; then
  echo "You must specify the product to update!"
  exit 1
else
  SHA="$(curl -Ss https://omnitruck.chef.io/stable/$1/metadata\?p=mac_os_x\&pv=10.13\&m=x86_64\&v=$VERSION | sed -n 's/sha256\s*\(.*\)/\1/p')"

  # make sure we got back a sha256 value
  if [ -z "$SHA" ]; then
    echo "Omnitruck did not return a SHA256 value for the $1 $VERSION!"
    exit 1
  fi

  echo Updating Cask $1
  echo Updating version to $VERSION
  echo Updating sha to $SHA

  sed -i -r "s/(version\s*\".+\")/version \"$VERSION\"/g" Casks/$1.rb
  sed -i -r "s/(sha256\s*\".+\")/sha256 \"$SHA\"/g" Casks/$1.rb

fi
