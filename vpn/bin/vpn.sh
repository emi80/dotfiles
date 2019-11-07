#!/bin/bash

connect() {
    CFG=$(mktemp)
    LOG=~/.crgvpn.log
    cat ~/.crgvpn > $CFG
    echo "password = $(secret-tool lookup vpn CRG)" >> $CFG
    sudo openfortivpn -c $CFG  &> $LOG &
    while [ ! "$(grep 'Tunnel is up and running' $LOG)" ]; do sleep 1; done
    rm $CFG
}

disconnect() {
    sudo pkill openfortivpn	
}

ON="$(pgrep openfortivpn)"

if [ -z "$ON" ]; then
    connect
    notify-send "Connected to VPN CRG"
else
    disconnect
    notify-send "Disconnected from VPN CRG"
fi
