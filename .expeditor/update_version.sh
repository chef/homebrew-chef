#!/bin/bash

# This bumps the version in the ENV var 'VERSION' on the project specified
# It fetches the sha256 via omnitruck api

set -ex

branch="expeditor/${PRODUCT_KEY}_${VERSION}"
git checkout -b "$branch"

URL="https://omnitruck.chef.io/stable/$PRODUCT_KEY/metadata?p=mac_os_x&pv=10.14&m=x86_64&v=$VERSION"
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

git add .

# give a friendly message for the commit and make sure it's noted for any future audit of our codebase that no
# DCO sign-off is needed for this sort of PR since it contains no intellectual property
git commit --message "Bump $PRODUCT_KEY to $VERSION" --message "This pull request was triggered automatically via Expeditor when $PRODUCT_KEY $VERSION was promoted to stable." --message "This change falls under the obvious fix policy so no Developer Certificate of Origin (DCO) sign-off is required."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
