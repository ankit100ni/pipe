#!/bin/bash

# Cookbook validation
# Version check
    # Define a function that returns true if cookbook version passed as argument 1
    # is greater than or equal to the cookbook version passed as argument 2
    # semver_gte() {
    #   # [ "$1" == "$( echo -e "$1\n$2" | sort -rV | head -n1 )" ]
    #   if [ "$1" -ge "$2" ]; then
    #     echo 'ERROR: Cookbook version must be greater than the version in the dev branch'
    #     exit 1
    #   fi
    # }
    # Grab the version strings from the dev and current branches'

#!/bin/bash

# Function to format floating-point numbers with a specific precision
dev_version=$( git show origin/dev:metadata.rb | grep "^version" | tr '"' "'" | cut -f2 -d\' )
branch_version=$( grep "^version" metadata.rb | tr '"' "'" | cut -f2 -d\' )

IFS='.' read -ra v1_components <<< "$dev_version"
IFS='.' read -ra v2_components <<< "$branch_version"

if [ "${v1_components[0]}" -gt "${v2_components[0]}" ]; then
    echo "$dev_version is greater than $branch_version."
elif [ "${v1_components[0]}" -lt "${v2_components[0]}" ]; then
    echo "$dev_version is less than $branch_version."
else
    if [ "${v1_components[1]}" -gt "${v2_components[1]}" ]; then
        echo "$dev_version is greater than $branch_version."
    elif [ "${v1_components[1]}" -lt "${v2_components[1]}" ]; then
        echo "$dev_version is less than $branch_version."
    else
        if [ "${v1_components[2]}" -gt "${v2_components[2]}" ]; then
            echo "$dev_version is greater than $branch_version."
        elif [ "${v1_components[2]}" -lt "${v2_components[2]}" ]; then
            echo "$dev_version is less than $branch_version."
        else
            echo "$dev_version is equal to $branch_version."
        fi
    fi
fi