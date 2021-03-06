#!/bin/bash

#Sample command: ./decrypt-tool.sh plans wheaton
ipath=./$1 #encrypted message filepath
pass=$2

echo $ipath

echo "Looping through openssl cipher flags"

while read p; do
  echo $p >> decrypted #appending lines showing which flags are used in openssl
  openssl enc $p -base64 -i -d -in $ipath -k $pass >> decrypted #appending all results here
done < ./ciphers.txt
