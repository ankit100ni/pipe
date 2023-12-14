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

# Output file location
sudo mkdir -p ~/.chef
output_file="~/.chef/credentials"

# Function to create the configuration file
create_config_file() {
  echo "[default]" > "$1"
  echo "client_name     = \"$client_name\"" >> "$1"
  echo "client_key      = '/home/runner/.chef/$client_key_name.pem'" >> "$1"
  echo "chef_server_url = 'https://ec2-13-127-199-32.ap-south-1.compute.amazonaws.com/organizations/$org_name'" >> "$1"
}

# Parse JSON and extract values into variables in a loop
echo "$json_data" | jq -r 'to_entries[] | "\(.key):client_name=\(.value.client_name)\nclient_key_name=\(.value.client_key_name)\norg_name=\(.value.org_name)\n"' | while read -r line; do
  eval "$line"
  create_config_file "$output_file.$org_name"
done

echo "Configuration files created. Output files: $output_file.*"
cat ~/.chef/credentials
