#!/bin/bash

# make sure there is an input file specified
if [ "${1}" == "" ]; then
  echo "ERROR: no input file specified" > /dev/stderr
  exit 1
fi
input_file=${1}

# see if there is a password file specified
password_argument=""
if [ "${2}" != "" ]; then
  password=$(cat ${2})
  password_argument="-password pass:${password}"
fi

# set the output file names
cert_output_file=cert.crt
key_output_file=private.key

# extract the cert and private key
openssl pkcs12 -info -in ${input_file} -nokeys -out ${cert_output_file} ${password_argument}
openssl pkcs12 -info -in ${input_file} -nocerts -nodes -out ${key_output_file} ${password_argument}
