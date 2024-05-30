#!/bin/bash

# Configure database secrets

vault secrets enable database

vault write database/config/payments \
    plugin_name=postgresql-database-plugin \
    allowed_roles=writer,reader \
    connection_url="postgresql://{{username}}:{{password}}@10.100.0.180:5432/payments?sslmode=disable" \
    username="postgres" \
    password="password"

vault write -force database/rotate-root/payments

vault write database/roles/writer \
    db_name=payments \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; 
    GRANT SELECT, INSERT, UPDATE ON payment_card TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"

vault write database/roles/reader \
    db_name=payments \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; 
    GRANT SELECT ON payment_card TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"


# Configure spring boot

## copy file to /tmp


# Configure Database Encryption

vault secrets enable transit

vault write -f transit/keys/payments type=rsa-4096


# Integrating Transit with Spring Boot

## copy listener
## modify entity to add listener


# Configure Kubernetes

vault write auth/kubernetes/role/payments \
  bound_service_account_names=payments \
  bound_service_account_namespaces=default \
  token_policies=payments
  ttl=24h

vault policy write payments - <<EOF
path "database/creds/writer" {
  capabilities = ["read", "create"]
}

path "transit/encrypt/payments" {
  capabilities = ["update"]
}
EOF

## copy the deployment file

## confgiure static secrets
vault secrets enable -version=2 -path=secret kv
vault kv put secret/SpringVaultApplication password=H@rdT0Gu3ss
