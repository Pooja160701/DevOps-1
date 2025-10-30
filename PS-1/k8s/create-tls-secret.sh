#!/bin/bash
# Usage: ./k8s/create-tls-secret.sh wisecow.local

DOMAIN=$1

if [ -z "$DOMAIN" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout tls.key \
  -out tls.crt \
  -subj "/CN=${DOMAIN}/O=${DOMAIN}" \
  2>/dev/null

kubectl create secret tls wisecow-tls \
  --key tls.key \
  --cert tls.crt
