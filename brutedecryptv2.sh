#!/bin/bash

# Usage:
if [[ -z $1 ]]; then
    echo 'USAGE: ./brutedecypt.sh <input file> <output file> <password> [cipher]'
fi

# Arrange variables
INPUTFILE=$1
OUTPUTFILE=$2
PASSWORD=$3
CIPHER=$4

# If a specific cipher is not given then
# get list of ciphers using by openssl
if [[ -z $CIPHER ]]; then
    CIPHER=`openssl list -cipher-commands`
fi

#echo $CIPHER

# For each cipher type run the following command for each password
# (unless specific password given)
for c in $CIPHER; do
    openssl enc -d -${c} -in ${INPUTFILE} -k ${PASSWORD} > /dev/null 2>&1
    
    # Check to see if the command didn't fail the decryption
    # If it didn't alert user
    if [[ $? -eq 0 ]]; then
        # Display commands of possible decryption methods
        # Appends the cipher ont he end of the output file so more than one commands
        # Can be run at the same time
        echo "openssl enc -d -$c -in $INPUTFILE -out $OUTPUTFILE-$c -k $PASSWORD"
        #exit 0
    fi
done
