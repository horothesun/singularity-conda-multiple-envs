#!/usr/bin/expect

echo "IMAGE_FILENAME: $IMAGE_FILENAME"
echo "SINGULARITY_PGP_PASSPHRASE: $SINGULARITY_PGP_PASSPHRASE"

set timeout 60

spawn singularity sign $IMAGE_FILENAME

expect "Enter key passphrase : "
send -- "$SINGULARITY_PGP_PASSPHRASE\r"

expect eof
