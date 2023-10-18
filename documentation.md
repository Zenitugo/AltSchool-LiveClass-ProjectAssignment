# DOCUMENTATION


## STEP 1: VAGRANTFILE 

The deploy.sh script was created t0 initialize vagrant and then `cat` the configurations of the VMs into the Vagrantfile.
The configurations added to make it work properly were:  setting up a hostname, specifying  a private IP address **(192.168.56.106 for master and 192.168.56.107 for slave)** and a base box**(ubuntu/focal64)** for the VM and also including some commands to run while the shell is being provisioned. These commands include:

- installing `sshpass` to allow to run SSH using the keyboard-interactive password authentication mode, but in a non-interactive way.

- installing `avahi-daemon` and `libnss-mdns`: avahi-daemon was installed to let the master and slave machine find and communicate with each other easily since they are on the same network **(192.168.56.1/24)** while `libnss-mdns` was installed because it can translate user names into ip address. This is because if I ssh into vagrant@slave, it will know the sever I am trying to reach and bring it up.


- Also `apt update` and `apt upgrade was done`


## STEP 2: machines.sh

The scripts contains the commands for the installation of LAMP STACK for the Virtual machine instances **(master and slave)**. Machines.sh script for Slave and Machines01.sh for Master

This means I ran the commands to:
- Install apache2 web server.
- Install mysql database
- Instal php and its dependencies.
- Enable modules
- Restart apache
- Validate PHP
- Install Nginx on the load balancer VM


**It also contains the User management details of the master VM instance**

- A user called altschool was created

   ` sudo useradd -m -G sudo altschool`
- altschool user password was changed <ruby>

   `echo -e "ruby\nruby\n" | sudo passwd altschool`
- altschool user was given root (superuser) privileges by adding altschool user to the sudo group.

   `sudo usermod -aG sudo altschool`
- An ssh-key pair was generated for the altschool user, using this command:

   ` sudo -u altschool ssh-keygen -t rsa -b 4096 -f /home/altschool/.ssh/id_rsa -N "" `
- To copy the keys generated into another folder; I created a file and copied the keys into the file

  `sudo mkdir /home/altschool/accesskeys/keys.txt`

  `sudo cp /home/altschool/.ssh/id_rsa.pub /home/vagrant/accesskeys/altschoolkey.txt`

- An ssh key was created for user vagrant
    `sudo ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""`

-To send the contents of the public key file to the slave machine, I used the first command to read the content of the `.pub` file and used the pipe (|) to send it as an input to the second command (sshpass) and I used this command `StrictHostKeyChecking` to stop it from being prompted from receiving the slave host key.

The third part of the command `mkdir` will create a .ssh file on slave if the file does not exist and the public keys from master will be sent to the authorized_keys file in slave using `cat >>` command.
   `sudo cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p " " ssh -o StrictHostKeyChecking=no vagrant@192.168.56.107 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'`


- To also maake it possible for the altschool user to ssh into the slave machine, the ssh key that was generated and copied in the keys.txt file will be sent as an input to `sshpass` but will be using the vagrant's user password to connect to slave; so that it can be redirected to the authorized_key file in slave 
   
   `sudo cat /home/altschool/acceskeys/keys.txt | sshpass -p "vagrant" ssh vagrant@192.168.56.106 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'`


- To Copy the contents of /mnt/altschool directory from the Master node to /mnt/altschool/slave on the Slave node on initiation:

    `sshpass -p "ruby" sudo -u altschool mkdir -p /mnt/altschool/slave`
    
    `sshpass -p "ruby" ssh -o StrictHostKeyChecking=no vagrant@192.168.56.107 "sudo -u altschool scp -r -o StrictHostKeyChecking=no -i /home/vagrant/.ssh/id_rsa -p /mnt/* /home/vagrant/mnt/"`

- 




