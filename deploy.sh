#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
#hugo # if using a theme, replace by `
hugo -t hugo-kiera

# Go To Public folder
cd public
# Add changes to git.
git add -A

# Commit changes.
msg="removed some social sites `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back
cd ..

