# AltSchool-LiveClass-ProjectAssignment

## Project Task: Deployment of Vagrant Ubuntu Cluster with LAMP Stack

## Objective:
**Develop a bash script to orchestrate the automated deployment of two Vagrant-based Ubuntu systems, designated as 'Master' and 'Slave', with an integrated LAMP stack on both systems.**

## Specifications:
**Infrastructure Configuration:**
 - Deploy two Ubuntu systems:
      1. Master Node: This node should be capable of acting as a control system.
      2. Slave Node: This node will be managed by the Master node.
 - User Management:
      1. On the Master node create a user named altschool.
      2. Grant altschool user root (superuser) privileges.
 - Inter-node Communication:
      1. Enable SSH key-based authentication.
      2. The Master node (altschool user) should seamlessly SSH into the Slave node without requiring a password.
 - Data Management and Transfer:
      1. On initiation copy the contents of /mnt/altschool directory from the Master node to /mnt/altschool/slave on the Slave node. This operation should be performed using the altschool user from the Master node.
 - Process Monitoring:
      1. The Master node should display an overview of the Linux process management, showcasing currently running processes.
 - LAMP Stack Deployment:
      1. Install a LAMP (Linux, Apache, MySQL, PHP) stack on both nodes:
      2. Ensure Apache is running and set to start on boot.
      3. Secure the MySQL installation and initialize it with a default user and password.
      4. Validate PHP functionality with Apache.

## Deliverables:
A bash script that encapsulates the entire deployment process adhering to the abovementioned specifications.
Documentation accompanying the script, elucidating the steps and procedures for execution.
