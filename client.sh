#!/bin/sh

# Author: techgaun

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
. "${BASEDIR}/common.sh"
req=

trap 'exit 1' INT TERM

while :; do
    read req
    if [ "${req}" = "quit"  ]; then
        echo "Exiting..."
        exit 0
    fi
    echo "${req}" | encrypt | $NC $HOST $PORT
done

exit 0
