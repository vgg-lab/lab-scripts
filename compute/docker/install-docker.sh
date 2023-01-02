#!/bin/bash

# 0. Add docker group and user
sudo groupadd docker
sudo usermod -aG docker $USER


# 1. install docker 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh


distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
            
# 2. install rootless docker stuff
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo apt-get install -y docker-ce-rootless-extras uidmap

# 1. Vygenerovat IDcka
LINECOUNT=`cat /etc/subuid | wc -l`
if (( LINECOUNT < 1000)); then
    echo "Generating user IDs..."
    sudo python3 genids.py
fi

sudo cp setup-rootless-docker.sh /usr/local/bin

# Este cookiecutter pre vsetkych
sudo pip install cookiecutter


# 3. Start on boot
sudo systemctl enable containerd
sudo systemctl start containerd

sleep 2
echo ""
echo "Logout and log back in !!!"
sleep 2
