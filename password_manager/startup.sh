#!/bin/bash

# Function to generate an encryption key and store it in config.env
generate_key() {
    key=$(openssl rand -base64 32)  # 32-character encryption key
    echo "ENCRYPTION_KEY=$key" > config/config.env
    echo "Encryption key generated and saved in config/config.env."
}

# Function to set a master password
set_master_password() {
    echo "Set a master password for your password manager:"
    read -s master_password

    # Hash the master password and store it in config.env
    hashed_password=$(echo -n "$master_password" | openssl dgst -sha256 | awk '{print $2}')
    
    # Append the hashed password to config.env
    echo "MASTER_PASSWORD_HASH=$hashed_password" >> config/config.env
    echo "Master password has been set and stored."
}

# Check if the encryption key already exists
if [ ! -f config/config.env ]; then
    echo "No encryption key found. Generating a new one..."
    generate_key
    set_master_password
else
    echo "Encryption key and master password already exist."
fi

