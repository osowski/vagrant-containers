!#/bin/bash

#Pre-reqs
sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install curl \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual

#Install Docker
sudo apt-get install apt-transport-https \
  ca-certificates

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo apt-get install software-properties-common
sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

sudo apt-get update
sudo apt-get -y install docker-engine
sudo docker run hello-world

#Requires logout and login afterwards, should be fine after 'vagrant ssh'
#TODO Need to figure out 'sudo' and running docker as admins group
#sudo groupadd docker
sudo usermod -aG docker vagrant
