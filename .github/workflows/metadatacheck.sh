#!/bin/bash

# Cookbook validation
# Version check
- bash: |
    # Define a function that returns true if cookbook version passed as argument 1
    # is greater than or equal to the cookbook version passed as argument 2
    semver_gte() {
      [ "$1" == "$( echo -e "$1\n$2" | sort -rV | head -n1 )" ]
    }
    # Grab the version strings from the dev and current branches
    dev_version=$( git show origin/dev:metadata.rb | grep "^version" | tr '"' "'" | cut -f2 -d\' )
    branch_version=$( grep "^version" metadata.rb | tr '"' "'" | cut -f2 -d\' )
    echo 'Feature branch cookbook version:' $branch_version
    echo 'Dev branch cookbook version:' $dev_version
    if semver_gte "$dev_version" "$branch_version"; then
      echo 'ERROR: Cookbook version must be greater than the version in the dev branch'
      exit 1
    fi
  displayName: 'Cookbook version check' 