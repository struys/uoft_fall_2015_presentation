#!/bin/bash

set -ex

[ "$TRAVIS_BRANCH" == "real_master" -a "$TRAVIS_PULL_REQUEST" == "false" ] || exit

git clone "https://${GH_TOKEN}@${GH_REF}" out >& /dev/null
cd out
git checkout master
git config user.name "Travis-CI"
git config user.email "ken@struys.ca"
# Repo
cp ../.travis.yml .
# Website
cp -R ../build ../bower_components ../index.html ../*.png ../favicon.ico .

git add .
git commit -m "Deployed ${TRAVIS_BUILD_NUMBER} to Github Pages"
git push -q origin HEAD >& /dev/null
