#!/bin/bash


#Update Apt Package manager
    echo -e "\n\nUpdating Apt Package\n"
    sudo apt update -y

 #Installing Apache
    sudo apt install apache2 -y
    echo -e "\n\nAdding firewall rule to Apache\n"
    sudo ufw allow  "Apache"

 #Installing MySQL
    echo -e "\n\nInstalling MySQL\n"
    sudo apt install mysql-server -y
    echo -e "\n\nPermissions for /var/www\n"
    sudo chown -R www-data:www-data /var/www
    echo -e "\n\n Permissions have been set\n"
    sudo apt install php libapache2-mod-php php-mysql -y
    echo -e "\n\nEnabling Modules\n"
    sudo a2enmod rewrite
    sudo sed -i 's/DirectoryIndex index.html index.cgi index.pl index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.h>

 #To Ensure Apache is running and set to start on boot.
    echo -e "\n\nStarting Apache\n"
    sudo systemctl start apache2
    echo -e "\n\nEnabling Apache to start on boot\n"
    sudo systemctl enable apache2

#Secure the MySQL installation and initialize it with a default user and password.
    sudo mysql_secure_installation

#Create a test PHP page
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/test.php


    echo -e "\n\nLAMP Installation Completed"

#Create alt school user
    sudo useradd -m -G sudo altschool
#Create password for altschool user
    echo -e "ruby\nruby\n" | sudo passwd altschool
#add altschool user to sudeo group to give altschool user super privileges
    sudo usermod -aG sudo altschool
#Generate key pairs for altschooluser
    sudo -u altschool ssh-keygen -t rsa -b 4096 -f /home/altschool/.ssh/id_rsa -N ""
#Create a deirectory and cop the keys into the directory
    sudo mkdir -p /home/altschool/accesskeys/altschoolkey.txt
    sudo cp /home/altschool/.ssh/id_rsa.pub /home/altschool/accesskeys/keys.txt
#Create a keypair for vagrant user
    sudo ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""
# Copy the public keys of the vagrant user and input in the authorized key file of slave
    sudo cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@192.168.56.107 'mkdir -p ~/.ssh && cat >> ~/.ssh/autho>    sudo cat /home/altschool/acceskeys/keys.txt | sshpass -p "vagrant" ssh vagrant@192.168.56.106 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
#Copy 
    sshpass -p "ruby" sudo -u altschool mkdir -p /mnt/altschool/slave
    sshpass -p "ruby" ssh -o StrictHostKeyChecking=no vagrant@192.168.56.107 "sudo -u altschool scp -r -o StrictHostKeyChecking=no -i /home/vagrant/.ssh/id_rsa >
