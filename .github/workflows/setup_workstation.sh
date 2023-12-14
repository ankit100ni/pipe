#!/bin/bash

echo "$CHEFADMIN"

json_data=$1

# Output directory location
output_dir="$HOME/.chef"

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Parse JSON and extract values into variables in a loop
echo "$json_data" | jq -r 'to_entries[] | "\(.key) \(.value.client_name) \(.value.client_key_name) \(.value.org_name)"' | while read -r org client_name client_key_name org_name; do
  # Create the configuration file
  config_file="$output_dir/credentials"
  echo "[default]" > "$config_file"
  echo "client_name     = \"$client_name\"" >> "$config_file"
  echo "client_key      = '/home/runner/.chef/$client_key_name.pem'" >> "$config_file"
  echo "chef_server_url = 'https://ec2-13-127-199-32.ap-south-1.compute.amazonaws.com/organizations/$org_name'" >> "$config_file"
  
  echo "Configuration file created: $config_file"
  cat $config_file
done
