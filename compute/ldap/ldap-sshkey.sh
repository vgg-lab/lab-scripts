#!/bin/bash

# Find sshPublicKey for the given user and process 
# each entry into an authorized_keys format

if [ -z "$1" ]; then
  echo "No user id specified"
  exit 1;
fi

# Read variables from ldap.conf
CONF=/etc/ldap/ldap.conf

if [ -e "$CONF" ]; then
  while read -r var val; do
    export "$var"="$val"
  done <<< $(grep "^[^#]" $CONF)
fi

# Search LDAP and return the lines with no-wrap
ldapsearch -x \
  -D ${BINDDN} -w ${BINDPW} \
  -H ${URI} \
  -b ${BASE} "(&(objectClass=posixAccount)(uid=$1))" \
  -o ldif-wrap=no sshPublicKey | while read -r line; do
  # Double :: returns are multiline base64 encoded
  if [[ "$line" = sshPublicKey::* ]]; then
    echo "$line" | sed 's/sshPublicKey:: //' | base64 -d
  # Single : are direct public keys
  elif [[ "$line" = sshPublicKey:* ]]; then
    echo "$line" | sed 's/sshPublicKey: //'
  fi
done

