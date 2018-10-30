#!/bin/bash

# This bumps the version in the ENV var 'VERSION' on the project specified
# It fetches the sha256 via omnitruck api

set -ex

# make sure the API is ready to return a new product
sleep 240

URL="https://omnitruck.chef.io/stable/$PRODUCT_KEY/metadata?p=mac_os_x&pv=10.13&m=x86_64&v=$VERSION"
SHA="$(curl -Ssv $URL | sed -n 's/sha256\s*\(\S*\)/\1/p')"

# make sure we got back a sha256 value
if [ -z "$SHA" ]; then
  echo "Omnitruck did not return a SHA256 value for the $PRODUCT_KEY $VERSION!"
  echo "Tried to fetch from $URL"
  exit 1
fi

echo Updating Cask $PRODUCT_KEY
echo Updating version to $VERSION
echo Updating sha to $SHA

sed -i -r "s/(version\s*\".+\")/version \"$VERSION\"/g" Casks/$PRODUCT_KEY.rb
sed -i -r "s/(sha256\s*\".+\")/sha256 \"$SHA\"/g" Casks/$PRODUCT_KEY.rb
