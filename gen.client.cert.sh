#!/bin/sh

# 20211110
#Cert tools created by huy.do@cyberark.com
#Purpose: generating client certificates for lab and testing purpose
#

CERT_DIR="./certs"
mkdir -p $CERT_DIR

[ -f "$CERT_DIR/ca.crt" -a -f "$CERT_DIR/ca.key" ] || { echo "Root CA files are not existed. Please run gen.ca.cert to create them first."; exit; }


echo "Generating client Certs..."
openssl genrsa -aes256 -passout pass:changeme -out $CERT_DIR/client.pass.key 4096
openssl rsa -passin pass:changeme -in $CERT_DIR/client.pass.key -out $CERT_DIR/client.key
openssl req -new -key $CERT_DIR/client.key -out $CERT_DIR/client.csr -config cert-client.conf
openssl x509 -CAcreateserial -req -days 3650 -in $CERT_DIR/client.csr -CA $CERT_DIR/ca.crt -CAkey $CERT_DIR/ca.key -out $CERT_DIR/client.crt -extensions v3_req -extfile cert-client.conf

echo "Generating importable pfx. Enter password if you want to secure it ..."
cat $CERT_DIR/client.key $CERT_DIR/client.crt $CERT_DIR/ca.crt > $CERT_DIR/client.pem
openssl pkcs12 -export -out $CERT_DIR/client.pfx -inkey $CERT_DIR/client.key -in $CERT_DIR/client.pem -certfile $CERT_DIR/ca.crt
set +x
