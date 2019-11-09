#!/bin/bash
set -e
set -u

status=$(nmcli --fields general.state c show CRG)

op=down
[ -z "$status" ] && op=up

nmcli c $op CRG
