#!/bin/bash


sudo mkdir /srv/data/persist -m 777
sudo mkdir /srv/data/scratch -m 777


# Setup home mount
MOUNT_RESULT=`cat /etc/fstab | grep /persist`
if [ -z "${MOUNT_RESULT}" ]; then
    echo "Setting up fstab mounts for data"

    cp /etc/fstab fstab
    echo "" >> fstab
    sudo echo "/srv/data/persist      /mnt/persist     none    bind" >> fstab
    sudo echo "/srv/data/scratch      /mnt/scratch     none    bind" >> fstab
    sudo cp fstab /etc/fstab
    rm fstab

fi

