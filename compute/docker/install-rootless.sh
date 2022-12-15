#!/bin/bash

# 1. Vygenerovat IDcka
LINECOUNT=`cat /etc/subuid | wc -l`
if (( LINECOUNT < 1000)); then
    echo "Generating user IDs..."
    sudo python3 genids.py
fi

# 2. Pripravit config 