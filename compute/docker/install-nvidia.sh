#!/bin/bash

DRIVER_VERSION=525

sudo apt-get install -y nvidia-headless-${DRIVER_VERSION}-server
sudo apt-get install -y nvidia-utils-${DRIVER_VERSION}-server

