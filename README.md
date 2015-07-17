# bash-backdoor
A simple backdoor in (ba)sh

It is cross-compatible across POSIX shells. While I initially decided to write for bash, I decided to use /bin/sh later.

This little backdoor works well with traditional netcat with -e option but it can be easily ported to support openbsd variant by making use of file descriptors.

* The data over communication channel is totally encrypted with aes-256-cbc using openssl.
* You can generate new key, salt and iv. Check [common.sh](common.sh) for reference
* You can pass several options as env-vars. Check [common.sh](common.sh) for reference

### Usage
Run daemon.sh

`$ ./daemon.sh`

Run client.sh

`$ ./client.sh`

You can run command on the simple prompt in your client-side now.

### Known Issues
[#1](https://github.com/techgaun/bash-backdoor/issues/1)
