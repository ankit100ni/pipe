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

# Parse JSON and extract values into variables in a loop
echo "$json_data" | jq -r 'to_entries[] | "\(.key): Client Name: \(.value.client_name), Client Key Name: \(.value.client_key_name), Org Name: \(.value.org_name)"' | while read -r line; do
  org_key=$(echo "$line" | cut -d':' -f1)
  client_name=$(echo "$line" | grep -o 'Client Name: [^,]*' | cut -d' ' -f3-)
  client_key_name=$(echo "$line" | grep -o 'Client Key Name: [^,]*' | cut -d' ' -f4-)
  org_name=$(echo "$line" | grep -o 'Org Name: [^,]*' | cut -d' ' -f3-)

  echo "Org Key: $org_key"
  echo "Client Name: $client_name"
  echo "Client Key Name: $client_key_name"
  echo "Org Name: $org_name"

  sudo tee cat ~/.chef/credentials > /dev/null <<EOT
  [default]
  client_name     = "$client_name"
  client_key      = "/home/runner/.chef/$client_key_name.pem"
  chef_server_url = "https://ec2-13-127-199-32.ap-south-1.compute.amazonaws.com/organizations/$org_name"
  EOT
  sudo cat ~/.chef/credentials
  sudo echo "setup.sh executed"
  echo "---"

done
