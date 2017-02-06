!#/bin/bash

#Install CF
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
sudo apt-get update
sudo apt-get install cf-cli jq

#Install Bluemix CLI
CURRENT_BX_VERSION=$(curl -s http://clis.ng.bluemix.net/all_versions | jq -r .[0].version)
curl --output Bluemix_CLI_${CURRENT_BX_VERSION}_amd64.tar.gz http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/Bluemix_CLI_${CURRENT_BX_VERSION}_amd64.tar.gz
tar -xvf Bluemix_CLI_${CURRENT_BX_VERSION}_amd64.tar.gz
cd Bluemix_CLI
sudo ./install_bluemix_cli

#Install Plugins
export CF_HOME=/home/vagrant
export CF_PLUGIN_HOME=/home/vagrant

bx plugin install auto-scaling -r Bluemix
bx plugin install active-deploy -r Bluemix
bx plugin install vpn -r Bluemix
bx plugin install private-network-peering -r Bluemix
bx plugin install IBM-Containers -r Bluemix

cf add-plugin-repo bluemix-cf https://plugins.ng.bluemix.net
cf install-plugin -f Active-Deploy -r bluemix-cf
cf install-plugin -f vpn -r bluemix-cf
cf install-plugin -f IBM-Containers -r bluemix-cf

cf uninstall-plugin IBM-Containers
cf install-plugin -f https://static-ice.ng.bluemix.net/ibm-containers-linux_x64

cf api https://api.ng.bluemix.net

chown -R vagrant:vagrant /home/vagrant/.cf
