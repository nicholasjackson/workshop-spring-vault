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