#!/bin/sh

# Author: techgaun

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
. "${BASEDIR}/common.sh"

req=

while :; do
    read -r req
    req=$(decrypt "${req}")
    runcmd "$req"
done
