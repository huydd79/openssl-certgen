# Creating RootCA, Client and Server certificates Tools
By huy.do@cyberark.com
This repo contains scripts to create the certificate for lab or learning purpose. All scripts are using openssl and run in linux environment.
After running scripts, certificate and related files are written in ./certs folder.

## Repo contents
- Configuration files:
  - cert-ca.conf: configuration file for root CA
  - cert-client.conf: configuration file for sample client certificate request including subject alternative names such as email, DNS, IP...
  - cert-server.conf: configuration file for sample
- Script files:
  - gen.all.cert.sh: all in one command to generate ca, client and server certificates
  - gen.ca.cert.sh: generting ca.crt and ca.key. You can use this command to create your root ca certificate and using it to generate all other certificates for clients and servers
  - gen.server.cert.sh: generting server.crt, server.key and server.pfx files for server certificate. This certificate can be used for deploying https web server. You can change the cert-server.conf file content to generate diffirent server certificates using same root ca.
  - gen.client.cert.sh: generating client.crt, client.key and client.pfx files for client certificat. This certificate can be used for client authentication, email protection and code signing. You can change the cert-client.conf file content to generate diffirent client certificates using same root ca.

## Usage
- Cloning this repo into your linux environment with openssl installed.
```
git clone https://github.com/huydd79/openssl-certgen/
```
- Reviewing certificate configuration files. Change the content to your related system
- Running gen.all.cert.sh to generate the set of three ca, client, server certificates
- Running gen.server.cert.sh and client.cert.sh to generate additional server or client certificates

# --- END ---
