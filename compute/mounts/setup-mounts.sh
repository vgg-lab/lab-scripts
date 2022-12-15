#!/bin/bash

NFS_HOST=vggnas.fiit.stuba.sk
SRV_HOME=/srv/home

# Setup data mount
sudo mkdir -p /mnt/nfs-data
NFS_MOUNT_DATA=`cat /etc/fstab | grep /mnt/nfs-data`
if [ -z "${NFS_MOUNT_DATA}" ]; then
    echo "Setting up mount /mnt/nfs-data."

    sudo echo "" >> /etc/fstab
    sudo echo "${NFS_HOST}:/volume1/nfs-data /mnt/nfs-data nfs defaults 0 0" >> /etc/fstab

    # Mount the data folder!
    sudo mount /mnt/nfs-data
fi

# Move home directory to SRV
sudo mkdir -m 755 -p ${SRV_HOME}
TARGET_HOME=${SRV_HOME}/${USER}
if [ ! -d ${TARGET_HOME} ]; then
    echo "Moving ${HOME}/${USER} -> ${TARGET_HOME}"
    sudo mv ${HOME}/${USER} ${TARGET_HOME}
    sudo usermod -d ${TARGET_HOME} ${USER}
fi

# Setup home mount
NFS_MOUNT_HOME=`cat /etc/fstab | grep /home`
if [ -z "${NFS_MOUNT_DATA}" ]; then
    echo "Setting up mount /home."

    sudo echo "" >> /etc/fstab
    sudo echo "${NFS_HOST}:/volume1/nfs-homes /home nfs auto,_netdev,nolock 0 0" >> /etc/fstab

    # Mount the home folder!
    sudo mount /home
fi
