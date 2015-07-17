#!/bin/sh

# Author: techgaun

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
. "${BASEDIR}/common.sh"
req=

trap 'quit' INT TERM QUIT

echo "Enter quit to exit"
while :; do
    printf "$ "
    read req
    if [ "${req}" = "quit"  ]; then
        quit
    fi
    response=$(encrypt "${req}" | "${NC}" "${BIND_HOST}" "${BIND_PORT}")
    decrypt "${response}"
done

exit 0
