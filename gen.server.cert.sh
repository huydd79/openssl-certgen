#!/bin/sh

# 20211110
#Cert tools created by huy.do@cyberark.com
#Purpose: generating server certificates for lab and testing purpose
#

CERT_DIR="./certs"
mkdir -p $CERT_DIR

[ -f "$CERT_DIR/ca.crt" -a -f "$CERT_DIR/ca.key" ] || { echo "Root CA files are not existed. Please run gen.ca.cert to create them first."; exit; }


echo "Generating Server Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/server.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/server.pass.key -out $CERT_DIR/server.key
openssl req -new -key $CERT_DIR/server.key -out $CERT_DIR/server.csr -config cert-server.conf
openssl x509 -CAcreateserial -req -days 3650 -in $CERT_DIR/server.csr -CA $CERT_DIR/ca.crt -CAkey $CERT_DIR/ca.key -out $CERT_DIR/server.crt -extensions v3_req -extfile cert-server.conf

echo "Generating importable pfx. Enter password if you want to secure it ..."
cat $CERT_DIR/server.key $CERT_DIR/server.crt $CERT_DIR/ca.crt > $CERT_DIR/server.pem
openssl pkcs12 -export -out $CERT_DIR/server.pfx -inkey $CERT_DIR/server.key -in $CERT_DIR/server.pem -certfile $CERT_DIR/ca.crt
set +x
