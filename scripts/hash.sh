#!/usr/bin/env bash


echo ">>> Enter cleartext password"
read -r cleartextpw
hash=$(echo "$cleartextpw" | mkpasswd --method=SHA-512 --rounds=4096 -s)


echo "hash: $hash"
echo "pw: $cleartextpw"
