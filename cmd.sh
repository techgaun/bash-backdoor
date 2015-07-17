#!/bin/sh

# Author: techgaun

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
. "${BASEDIR}/common.sh"

req=
read -r req
req=$(decrypt "${req}")
runcmd "${req}"
