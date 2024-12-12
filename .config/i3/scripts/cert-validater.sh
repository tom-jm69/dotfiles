#!/bin/bash

# Script to check SSL/TLS certificate for a provided domain
# Usage: ./check_cert.sh example.com

# Ensure domain is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1
PORT=443

echo "Checking SSL/TLS certificate for domain: $DOMAIN..."

# Retrieve the certificate details using OpenSSL
CERT_INFO=$(echo | openssl s_client -servername "$DOMAIN" -connect "$DOMAIN:$PORT" 2>/dev/null | openssl x509 -noout -dates)

if [ -z "$CERT_INFO" ]; then
  echo "Error: Could not retrieve certificate information. Make sure the domain is correct and supports HTTPS."
  exit 1
fi

# Parse certificate expiration date
EXPIRATION_DATE=$(echo "$CERT_INFO" | grep "notAfter=" | sed 's/notAfter=//')
EXPIRATION_TIMESTAMP=$(date -d "$EXPIRATION_DATE" +%s)
CURRENT_TIMESTAMP=$(date +%s)

# Calculate days remaining
DAYS_REMAINING=$(( (EXPIRATION_TIMESTAMP - CURRENT_TIMESTAMP) / 86400 ))

if [ "$DAYS_REMAINING" -le 0 ]; then
  echo "The SSL/TLS certificate for $DOMAIN has expired on $EXPIRATION_DATE."
else
  echo "The SSL/TLS certificate for $DOMAIN is valid."
  echo "Expiration Date: $EXPIRATION_DATE"
  echo "Days Remaining: $DAYS_REMAINING days"
fi
