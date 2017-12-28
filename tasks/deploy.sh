#!/bin/bash
#
# Script to perform a Hugo deploy to a public HTML directory.
#

HUGO_DEST="$HOME/public_html"

echo -e "Deploy started."

# Step 1: `npm install`
echo -e "\nRunning \`npm install\`."
npm install

# Test if npm install is successful
RESULT_NPM=$?
if [ $RESULT_NPM -ne 0 ]; then
  # Exit if failed
  echo -e "\nDeployment failed: \`npm install\` failed."
  exit 1
fi

# Step 1: `npm run build`
echo -e "\nBuilding JS/CSS files."
npm run build

# Test if npm run build is successful
RESULT_NPM_BUILD=$?
if [ $RESULT_NPM_BUILD -ne 0 ]; then
  # Exit if failed
  echo -e "\nDeployment failed: Compiling JS + Assets failed."
  exit 1
fi

# Step 3: build Hugo
echo -e "\nBuilding Hugo site to ${HUGO_DEST}..."
hugo -d $HUGO_DEST

# Test if Hugo build is successful
RESULT_HUGO=$?
if [ $RESULT_HUGO -ne 0 ]; then
  # Exit if build failed
  echo -e "\nDeployment failed: Hugo build failed."
  exit 1
fi

echo -e "\nHugo build successful."
