#!/bin/bash

sudo systemctl stop docker
sudo systemctl stop containerd

# Remove docker packages
sudo apt-get remove -y docker*
sudo apt-get purge -y docker*

# Delete docker files
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
