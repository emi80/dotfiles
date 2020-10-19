#!/bin/bash
set -e
set -u

dev=${BT_DEV-$2}
dev=$(echo $dev | tr ':' '_')

if [ $1 == up ]; then
    cmd=Up
elif [ $1 == down ]; then
    cmd=Down
else
    echo "Unsupported command: $1" > /dev/stderr
    exit -1
fi
dbus-send --print-reply --system --dest=org.bluez /org/bluez/hci0/dev_${dev} org.bluez.MediaControl1.Volume${cmd}
