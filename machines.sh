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
    sudo sed -i 's/DirectoryIndex index.html index.cgi index.pl index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

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
