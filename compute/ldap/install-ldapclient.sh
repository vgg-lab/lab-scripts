#!/bin/bash


sudo apt-get install -y libnss-ldap libpam-ldap ldap-utils
sudo apt-get install -y nscd

sudo cp nsswitch.conf /etc/nsswitch.conf
sudo cp common-password /etc/pam.d/common-password
sudo cp common-session /etc/pam.d/comon-session


# Resolve public SSH keys from LDAP
TARGET_FILE=/usr/local/bin/ldap-sshkey.sh
if [ ! -f "${TARGET_FILE}"]; then
    echo "Installing LDAP-SSHKEY script."
    sudo cp ldap-sshkey.sh ${TARGET_FILE}
    sudo chown root:users ${TARGET_FILE}
fi
sudo cp ldap.conf /etc/ldap/ldap.conf
