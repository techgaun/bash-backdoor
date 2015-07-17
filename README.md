# bash-backdoor
A simple backdoor in (ba)sh

It is cross-compatible across POSIX shells. While I initially decided to write for bash, I decided to use /bin/sh later.

This little backdoor works well with traditional netcat with -e option but it can be easily ported to support openbsd variant by making use of file descriptors.
