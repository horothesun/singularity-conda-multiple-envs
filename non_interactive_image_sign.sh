#!/usr/bin/expect

set timeout 60

spawn singularity sign $IMAGE_FILENAME

expect "Enter key passphrase : "
send -- "$SINGULARITY_PGP_PASSPHRASE\r"

expect eof