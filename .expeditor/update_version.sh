#!/bin/bash

# This bumps the version in the ENV var 'VERSION' on the project specified
# It fetches the sha256 via omnitruck api

set -ex

URL="https://omnitruck.chef.io/stable/$PRODUCT_KEY/metadata?p=mac_os_x&pv=10.13&m=x86_64&v=$VERSION"
SHA=""

function get_sha() {
  curl -Ssv $URL | sed -n 's/sha256\s*\(\S*\)/\1/p'
}

tries=12
for (( i=1; i<=$tries; i+=1 )); do
  SHA=$(get_sha)
  if [ -z "$SHA" ]; then
    if [ $i -eq $tries ]; then
      echo "Omnitruck did not return a SHA256 value for the $PRODUCT_KEY $VERSION!"
      echo "Tried to fetch from $URL"
      exit 1
    else
      sleep 20
    fi
  else
    echo "Found Omnitruck artifact for $PRODUCT_KEY $VERSION"
    break
  fi
done

echo Updating Cask $PRODUCT_KEY
echo Updating version to $VERSION
echo Updating sha to $SHA

sed -i -r "s/(version\s*\".+\")/version \"$VERSION\"/g" Casks/$PRODUCT_KEY.rb
sed -i -r "s/(sha256\s*\".+\")/sha256 \"$SHA\"/g" Casks/$PRODUCT_KEY.rb
