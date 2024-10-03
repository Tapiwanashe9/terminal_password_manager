#!/bin/bash

# Generate an encryption key and store it in config.env
generate_key() {
    key=$(openssl rand -base64 32)  # 32-character encryption key
    echo "ENCRYPTION_KEY=$key" > config/config.env
    echo "Encryption key generated and saved in config/config.env."
}

# Check if the encryption key already exists
if [ ! -f config/config.env ]; then
    echo "No encryption key found. Generating a new one..."
    generate_key
else
    echo "Encryption key already exists."
fi

