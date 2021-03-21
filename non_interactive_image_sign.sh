#!/usr/bin/expect

set timeout 60

spawn singularity sign $env(IMAGE_FILENAME)

expect "Enter key passphrase : "
send $env(SINGULARITY_PGP_PASSPHRASE)\r

expect eof
