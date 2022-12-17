#!/bin/bash

# 0. Add docker group and user
sudo groupadd docker
sudo usermod -aG docker $USER


# 1. install docker 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# 2. install rootless docker stuff
sudo apt-get install -y docker-ce-rootless-extras uidmap

# 1. Vygenerovat IDcka
LINECOUNT=`cat /etc/subuid | wc -l`
if (( LINECOUNT < 1000)); then
    echo "Generating user IDs..."
    sudo python3 genids.py
fi

sudo cp setup-rootless-docker.sh /usr/local/bin



# 3. Start on boot
sudo systemctl enable containerd
sudo systemctl start containerd

sleep 2
echo ""
echo "Logout and log back in !!!"
sleep 2
