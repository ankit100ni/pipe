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

# Use jq to get the keys of the JSON object
org_keys=($(echo "$json_data" | jq -r 'keys_unsorted[]'))

# Iterate over the keys
for org_key in "${org_keys[@]}"; do
  client_name=$(echo "$json_data" | jq -r ".[$org_key].client_name")
  client_key_name=$(echo "$json_data" | jq -r ".[$org_key].client_key_name")
  org_name=$(echo "$json_data" | jq -r ".[$org_key].org_name")

  echo "Org Key: $org_key"
  echo "Client Name: $client_name"
  echo "Client Key Name: $client_key_name"
  echo "Org Name: $org_name"
  echo "---"
done
