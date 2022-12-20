#!/bin/bash

MNT_PERSIST=/mnt/persist
MNT_SCRATCH=/mnt/scratch

MNT_PERSIST_USER=${MNT_PERSIST}/${USER}
MNT_SCRATCH_USER=${MNT_SCRATCH}/${USER}
MNT_PERSIST_USER_DOCKER=${MNT_PERSIST_USER}/.docker

# 0. Sanity check
if [ ! -d ${MNT_PERSIST} ]; then
    >&2 echo "Error: location ${MNT_PERSIST} does not exist"
    exit 1
fi

# Prepare persist user folder
if [ ! -d ${MNT_PERSIST_USER} ]; then
    mkdir ${MNT_PERSIST_USER}
    chmod 755 ${MNT_PERSIST_USER}
fi

# Prepare persist user folder
if [ ! -d ${MNT_SCRATCH_USER} ]; then
    mkdir ${MNT_SCRATCH_USER}
    chmod 755 ${MNT_SCRATCH_USER}
fi

# 2. Pripravit config a folder na docker
mkdir -p ${HOME}/.config/docker
mkdir -p ${MNT_PERSIST_USER_DOCKER}
echo "{ \"data-root\": \"${MNT_PERSIST_USER_DOCKER}\" }" > ${HOME}/.config/docker/daemon.json

#------------------------------------------------
# 3. Install RootLess Docker mode
#------------------------------------------------
dockerd-rootless-setuptool.sh install

# 4. export XDG Runtime stuff
XDG_CURRENT_RUNTIME_DIR=`cat ~/.profile | grep XDG_RUNTIME_DIR`
if [ -z "${XDG_CURRENT_RUNTIME_DIR}" ]; then
    echo "Exporting XDG_RUNTIME_DIR into ~/.profile"

    echo "" >> ~/.profile
    echo "# Rootless docker setup" >> ~/.profile
    echo "export XDG_RUNTIME_DIR=/run/user/\$(id -u)" >> ~/.profile
    echo "export PATH=/usr/bin:\$PATH" >> ~/.profile
    echo "export DOCKER_HOST=unix://\$XDG_RUNTIME_DIR/docker.sock" >> ~/.profile
    echo "" >> ~/.profile
fi

# Start docker
systemctl --user enable docker
systemctl --user start docker
