#!/bin/bash


sudo chmod 777 /mnt/persist
sudo chmod 777 /mnt/scratch

sudo apt-get install -y nfs-common

NFS_HOST=nas.vgg.lab
SRV_HOME=/srv/home

# Setup data mount
sudo mkdir -p /mnt/nfs-data
NFS_MOUNT_DATA=`cat /etc/fstab | grep /mnt/nfs-data`
if [ -z "${NFS_MOUNT_DATA}" ]; then
    echo "Setting up mount /mnt/nfs-data."

    cp /etc/fstab fstab
    echo "" >> fstab
    echo "${NFS_HOST}:/volume1/nfs-data /mnt/nfs-data nfs defaults 0 0" >> fstab
    sudo cp fstab /etc/fstab
    rm fstab

    # Mount the data folder!
    sudo mount /mnt/nfs-data
fi

# Move home directory to SRV
#sudo mkdir -m 755 -p ${SRV_HOME}
#TARGET_HOME=${SRV_HOME}/${USER}
#if [ ! -d ${TARGET_HOME} ]; then
#    echo "Moving ${HOME} -> ${TARGET_HOME}"
#    sudo mv ${HOME} ${TARGET_HOME}
#    sudo usermod -d ${TARGET_HOME} ${USER}
#fi

# Setup home mount
NFS_MOUNT_HOME=`cat /etc/fstab | grep /home`
if [ -z "${NFS_MOUNT_HOME}" ]; then
    echo "Setting up mount /home."

    cp /etc/fstab fstab
    echo "" >> fstab
    sudo echo "${NFS_HOST}:/volume1/nfs-homes /home nfs auto,_netdev,nolock 0 0" >> fstab
    sudo cp fstab /etc/fstab
    rm fstab

    echo ""
    echo "Remember to mount /home !!"
fi

