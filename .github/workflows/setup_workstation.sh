#!/bin/bash

json_data='{
  "org1": {
    "client_name": "chefadmin",
    "client_key_name": "CHEFADMIN",
    "org_name": "qa"
  },
  "org2": {
    "client_name": "testuser",
    "client_key_name": "TESTUSER",
    "org_name": "chef_standalone"
  }
}'

# Iterate over keys using jq
for org_key in $(echo "$json_data" | jq -r 'keys_unsorted[]'); do
  client_name=$(echo "$json_data" | jq -r ".[$org_key].client_name")
  client_key_name=$(echo "$json_data" | jq -r ".[$org_key].client_key_name")
  org_name=$(echo "$json_data" | jq -r ".[$org_key].org_name")
  echo "Organization Key: $org_key"
done
