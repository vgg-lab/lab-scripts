#!/bin/bash

MNT_PERSIST=/mnt/persist
MNT_SCRATCH=/mnt/scratch

MNT_PERSIST_USER=${MNT_PERSIST}/${USER}
MNT_PERSIST_USER_DOCKER=${MNT_PERSIST_USER}/.docker

# 0. Sanity check
if [ ! -d ${MNT_PERSIST} ]; then
    >&2 echo "Error: location ${MNT_PERSIST} does not exist"
    exit 1
fi

# Prepare persist user folder
if [ ! -d ${MNT_PERSIST_USER} ]; then
    mkdir ${MNT_PERSIST_USER}
fi

# 2. Pripravit config a folder na docker
mkdir -p ${HOME}/.config/docker
mkdir -p ${MNT_PERSIST_USER_DOCKER}
echo "{ \"data-root\": \"${MNT_PERSIST_USER_DOCKER}\" }" > ${HOME}/.config/docker/daemon.json

