sudo mkdir -p ~/.chef
sudo tee cat ~/.chef/credentials > /dev/null <<EOT
[default]
client_name     = 'chefadmin'
client_key      = '/home/runner/.chef/chefadmin.pem'
chef_server_url = 'https://ec2-13-127-199-32.ap-south-1.compute.amazonaws.com/organizations/qa'
EOT
sudo cat ~/.chef/credentials
sudo echo "setup.sh executed"
# sudo echo "${{ secrets.CHEFADMIN_KEY }}" > ~/.chef/chefadmin.pem
