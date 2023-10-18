#!/bin/bash

#Initialise the process by running the command
vagrant init ubuntu/focal64

cat <<EOF  >  Vagrantfile
Vagrant.configure("2") do |config|

  config.vm.define "slave" do |subconfig|

    subconfig.vm.hostname = "slave"
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.network "private_network", ip: "192.168.56.107"

    subconfig.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt install sshpass -y
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt-get install -y avahi-daemon libnss-mdns
    SHELL
  end

  config.vm.define "master" do |subconfig|

    subconfig.vm.hostname = "master"
    subconfig.vm.box = "ubuntu/focal64"
    subconfig.vm.network "private_network", ip: "192.168.56.106"

    subconfig.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y avahi-daemon libnss-mdns
    sudo apt install sshpass -y
   # sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
   # sudo systemctl restart sshd
    SHELL
  end

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.cpus = "2"
    end
end
EOF




cluster='Vagrantfile'

if [ -e $cluster ]
then
	echo "Starting 'Slave' VM..."
        vagrant up slave

        echo "Starting 'Master' VM..."
         vagrant up master
	 vagrant ssh  master
else
	 echo "File not present"
fi

echo "Deployment complete!"

