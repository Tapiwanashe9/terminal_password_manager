#!/bin/bash

# Encrypt a password
encrypt_password() {
    local password="$1"
    local key=$(grep 'ENCRYPTION_KEY=' ../config/config.env | cut -d '=' -f2)
    echo -n "$password" | openssl enc -aes-256-cbc -a -salt -pass pass:"$key"
}

# Decrypt a password
decrypt_password() {
    local encrypted_password="$1"
    local key=$(grep 'ENCRYPTION_KEY=' ../config/config.env | cut -d '=' -f2)
    echo "$encrypted_password" | openssl enc -aes-256-cbc -d -a -pass pass:"$key"
}

