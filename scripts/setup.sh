#!/bin/bash

function fetch_vault {
  VAULT_BASE=https://releases.hashicorp.com/vault/
  VAULT_VERSION=1.9.3
  VAULT_OS="linux"
  VAULT_ARCH="amd64"

  # Determine the OS and architecure 
  OS=$(uname)
  ARCH=$(uname -m)

  if [ "${ARCH}" == "x86_64" ]; then
    VAULT_ARCH="amd64"
  fi
  
  if [ "${ARCH}" == "amd64" ]; then
    VAULT_ARCH="amd64"
  fi
  
  if [ "${OS}" == "Linux" ]; then
    VAULT_OS="linux"
  fi
  
  if [ "${OS}" == "Darwin" ]; then
    VAULT_OS="darwin"
  fi

  VAULT_FILE_URI=vault_${VAULT_VERSION}_${VAULT_OS}_${VAULT_ARCH}.zip
  VAULT_URI="${VAULT_BASE}${VAULT_VERSION}/${VAULT_FILE_URI}"

  wget $VAULT_URI -O /tmp/vault.zip
  unzip /tmp/vault.zip -d ./
  rm /tmp/vault.zip
}

# Fetch Vault
if [ ! -f "./vault" ]; then
  fetch_vault
fi

# Run Vault
echo "Starting Vault... To stop, run: pkill vault"
echo "####################################"
echo ""
nohup sh -c "./vault server -dev -dev-root-token-id=root" > vault.log & > /dev/null 2>&1

sleep 5

export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=root

# Enable transit secrets 
./vault secrets enable transit

# Create a key for hashing data
./vault write -f transit/keys/my-hash-key

# Create a key for encrypting data
./vault write -f transit/keys/my-encryption-key

# Configure AppId
vault auth enable approle

# Create an example secret
vault kv put secret/spring-vault-example api_key=12345abcdef

# Create a role
vault write auth/approle/role/spring-vault-example \
    secret_id_ttl=60m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=default,spring-vault-example

# Create the policy for the app
cat << EOF > ./spring-vault-example.hcl
path "secret/data/spring-vault-example" {
  capabilities = ["read"]
}
# Allow the app to HMAC data using the default sha2-256
path "transit/hmac/my-hash-key" {
  capabilities = ["update"]
}
# Only allow encryption with this policy
path "transit/encrypt/my-encryption-key" {
  capabilities = ["update"]
}
EOF

vault policy write spring-vault-example ./spring-vault-example.hcl

rm ./spring-vault-example.hcl

echo ""
echo "Login Credentials:"
echo "#####################################"
echo ""
# Fetch the approle login
ROLE_ID=$(vault read auth/approle/role/spring-vault-example/role-id | grep 'role_id' | sed -e 's/role_id\(\s\)*\(.*\)/\2/g')

# Fetch the approle secret
SECRET_ID=$(vault write -f auth/approle/role/spring-vault-example/secret-id | grep 'secret_id ' | sed -e 's/secret_id\(\s\)*\(.*\)/\2/g')

echo "Role ID:   ${ROLE_ID}"
echo "Secret ID: ${SECRET_ID}"

echo ""
echo "Set the following environment variables to allow the spring boot app to authenticate with Vault:"
echo "export SPRING_CLOUD_VAULT_APP_ROLE_ROLE_ID=${ROLE_ID}"
echo "export SPRING_CLOUD_VAULT_APP_ROLE_SECRET_ID=${SECRET_ID}"