#!/usr/bin/env sh

SERVER="services3"
MOUNT="/home/$HOME/storage"
MOUNT_POINT="/Users/$HOME/storage"
DNS="<local dns address>"

IP_ADDR=$(dig @"$DNS" +short "$SERVER")

while true; do
  if ! mount | grep "$MOUNT_POINT" >/dev/null 2>&1; then
    mount -t nfs "$IP_ADDR":"$MOUNT" "$MOUNT_POINT"
  fi
  sleep 10
done
