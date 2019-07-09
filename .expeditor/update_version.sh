#!/bin/bash

# This bumps the version in the ENV var 'EXPEDITOR_VERSION' on the project specified
# It fetches the sha256 via omnitruck api

set -ex

branch="expeditor/${EXPEDITOR_PRODUCT_KEY}_${EXPEDITOR_VERSION}"
git checkout -b "$branch"

URL="https://omnitruck.chef.io/stable/$EXPEDITOR_PRODUCT_KEY/metadata?p=mac_os_x&pv=10.14&m=x86_64&v=$EXPEDITOR_VERSION"
SHA=""

function get_sha() {
  curl -Ssv $URL | sed -n 's/sha256\s*\(\S*\)/\1/p'
}

echo "Sleeping for 10 minutes to let omnitruck catch up"
sleep 600

tries=12
for (( i=1; i<=$tries; i+=1 )); do
  SHA=$(get_sha)
  if [ -z "$SHA" ]; then
    if [ $i -eq $tries ]; then
      echo "Omnitruck did not return a SHA256 value for the $EXPEDITOR_PRODUCT_KEY $EXPEDITOR_VERSION!"
      echo "Tried to fetch from $URL"
      exit 1
    else
      sleep 20
    fi
  else
    echo "Found Omnitruck artifact for $EXPEDITOR_PRODUCT_KEY $EXPEDITOR_VERSION"
    break
  fi
done

echo Updating Cask $EXPEDITOR_PRODUCT_KEY
echo Updating version to $EXPEDITOR_VERSION
echo Updating sha to $SHA

sed -i -r "s/(version\s*\".+\")/version \"$EXPEDITOR_VERSION\"/g" Casks/$EXPEDITOR_PRODUCT_KEY.rb
sed -i -r "s/(sha256\s*\".+\")/sha256 \"$SHA\"/g" Casks/$EXPEDITOR_PRODUCT_KEY.rb

git add .

# give a friendly message for the commit and make sure it's noted for any future audit of our codebase that no
# DCO sign-off is needed for this sort of PR since it contains no intellectual property
git commit --message "Bump $EXPEDITOR_PRODUCT_KEY to $EXPEDITOR_VERSION" --message "This pull request was triggered automatically via Expeditor when $EXPEDITOR_PRODUCT_KEY $EXPEDITOR_VERSION was promoted to stable." --message "This change falls under the obvious fix policy so no Developer Certificate of Origin (DCO) sign-off is required."

open_pull_request

# Get back to master and cleanup the leftovers - any changed files left over at the end of this script will get committed to master.
git checkout -
git branch -D "$branch"
