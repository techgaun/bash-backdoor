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
    response=$(encrypt "${req}" | "${NC}" "${BIND_HOST}" "${BIND_PORT}")
    decrypt "${response}"
done

exit 0
