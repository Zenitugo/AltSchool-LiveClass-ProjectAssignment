#!/bin/bash

#cd /etc/nginx/sites-available

# Create a load-balancer file
sudo rm /etc/nginx/sites-available/load-balancer
sudo rm /etc/nginx/sites-enabled/load-balancer
sudo touch /etc/nginx/sites-available/load-balancer

# Create a new Nginx configuration file
sudo tee -a /etc/nginx/sites-available/load-balancer<<EOF
      upstream backend {
            server 192.168.56.106;  # IP address of the Master node
            server 192.168.56.107;  # IP address of the Slave node
    }

    server {
        listen 8080;
        server_name load-balancer;

        location / {
             proxy_pass http://backend;
             proxy_set_header Host \$host;
             proxy_set_header X-Real-IP \$remote_addr;
        }
    }
EOF

sudo ln -s /etc/nginx/sites-available/load-balancer /etc/nginx/sites-enabled

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply the new configuration
sudo systemctl restart nginx