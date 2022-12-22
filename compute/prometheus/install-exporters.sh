#!/bin/bash

NODE_EXPORTER_VERSION=1.5.0
FILENAME=node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
BASENAME=node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64
URL=https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/${FILENAME}

# 1. Node exporter
wget ${URL}
tar xvf ${FILENAME}
cd ${BASENAME}

# Copy node binary
sudo cp node_exporter /usr/local/bin
cd ..
rm -rf ./${BASENAME}
rm -f ${FILENAME}

# Create user
sudo useradd --no-create-home --shell /bin/false node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Exporter service
sudo cp node_exporter.service /etc/systemd/system/node_exporter.service
sudo systemctl daemon-reload
sudo systemctl start node_exporter



