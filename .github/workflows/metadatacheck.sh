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