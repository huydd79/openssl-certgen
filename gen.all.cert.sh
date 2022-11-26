#!/bin/sh

# 20211110
#Cert tools created by huy.do@cyberark.com
#Purpose: generating the set of root CA, client and server certificates for lab and testing purpose
#

CERT_DIR="./certs"
mkdir -p $CERT_DIR

set -x
echo "Generating CA Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/ca.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/ca.pass.key -out $CERT_DIR/ca.key
openssl req -new -x509 -days 3650 -key $CERT_DIR/ca.key -out $CERT_DIR/ca.crt -config cert-ca.conf

echo "Generating Server Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/server.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/server.pass.key -out $CERT_DIR/server.key
openssl req -new -key $CERT_DIR/server.key -out $CERT_DIR/server.csr -config cert-server.conf
openssl x509 -CAcreateserial -req -days 3650 -in $CERT_DIR/server.csr -CA $CERT_DIR/ca.crt -CAkey $CERT_DIR/ca.key -out $CERT_DIR/server.crt -extensions v3_req -extfile cert-server.conf

echo "Generating Client Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/client.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/client.pass.key -out $CERT_DIR/client.key
openssl req -new -key $CERT_DIR/client.key -out $CERT_DIR/client.csr -config cert-client.conf
openssl x509 -req -days 3650 -in $CERT_DIR/client.csr -CA $CERT_DIR/ca.crt -CAkey $CERT_DIR/ca.key -out $CERT_DIR/client.crt -extensions v3_req -extfile cert-client.conf

echo "Generating Client Certs..."
cat $CERT_DIR/client.key $CERT_DIR/client.crt $CERT_DIR/ca.crt > $CERT_DIR/client.pem
openssl pkcs12 -export -out $CERT_DIR/client.pfx -inkey $CERT_DIR/client.key -in $CERT_DIR/client.pem -certfile $CERT_DIR/ca.crt
set +x
