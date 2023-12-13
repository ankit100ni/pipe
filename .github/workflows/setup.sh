sudo mkdir -p ~/.chef
sudo tee cat ~/.chef/credentials > /dev/null <<EOT
[default]
client_name     = 'chefadmin'
client_key      = '/Users/anksoni/.chef/chefadmin.pem'
chef_server_url = 'https://@@@@server_fqdn@@@@/organizations/qa'
EOT
sudo cat ~/.chef/credentials
sudo chmod 777 ~/.chef
sudo ls -lhrt ~/.chef
sudo echo "${{ secrets.CHEFADMIN_KEY }}" > ~/.chef/chefadmin.pem
sudo ls -lhrt ~/
sudo echo "Jai Mata di"
sudo cat ~/.chef/chefadmin.pem