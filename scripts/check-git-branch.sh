#!/bin/sh
set -e

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NORMAL="\033[0m"

if [ $# -eq 0 ];then
    set -- $(git rev-parse --abbrev-ref HEAD)
fi

for b in $@; do
    LOCAL=$(git rev-parse $b@{0})
    REMOTE=$(git rev-parse $b@{u})
    BASE=$(git merge-base $b@{0} $b@{u})
    
    echo -en "Branch ${BLUE}$b${NORMAL}: "
    if [ $LOCAL = $REMOTE ]; then
        echo -e "${GREEN}Up-to-date${NORMAL}"
    elif [ $LOCAL = $BASE ]; then
        echo -e "${YELLOW}Need to pull${NORMAL}"
    elif [ $REMOTE = $BASE ]; then
        echo -e "${YELLOW}Need to push${NORMAL}"
    else
        echo -e "${RED}Diverged${NORMAL}"
    fi
done
