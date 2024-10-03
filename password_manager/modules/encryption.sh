#!/bin/bash

# Load the encryption key from the config file
source "$(dirname "$(realpath "$0")")/../config/config.env"

# Function to encrypt a password
encrypt_password() {
    echo "$1" | openssl enc -aes-256-cbc -a -salt -pass pass:"$ENCRYPTION_KEY"
}

# Function to decrypt a password
decrypt_password() {
    echo "$1" | openssl enc -aes-256-cbc -a -d -salt -pass pass:"$ENCRYPTION_KEY"
}

