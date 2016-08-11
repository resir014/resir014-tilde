#!/bin/bash
#
# Script to perform a Jekyll deploy to https://tilde.town/~resir014/
#

JEKYLL_DEST="$HOME/public_html"

echo -e "Building Jekyll site to ${JEKYLL_DEST}..."
bundle exec jekyll build -d $JEKYLL_DEST

# Test if Jekyll build is successful
RESULT_JEKYLL=$?
if [ $RESULT_JEKYLL -ne 0 ]; then
  # Exit if build failed
  echo -e "\nDeployment failed: Jekyll build failed."
  exit 1
fi

echo -e \
  "\nJekyll build successful."

