#!/bin/sh

# 20211110
#Cert tools created by huy.do@cyberark.com
#Purpose: generating the set of root CA certificates for lab and testing purpose
#

CERT_DIR="./certs"
mkdir -p $CERT_DIR

set -x
echo "Generating CA Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/ca.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/ca.pass.key -out $CERT_DIR/ca.key
openssl req -new -x509 -days 3650 -key $CERT_DIR/ca.key -out $CERT_DIR/ca.crt -config cert-ca.conf
