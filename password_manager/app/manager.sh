#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Include the encryption functions using an absolute path
source "$SCRIPT_DIR/../modules/encryption.sh"

# Function to store a password
store_password() {
    echo "Enter a label for this password (e.g., 'Gmail', 'Facebook'):"
    read label
    echo "Enter the password:"
    read password

    # Encrypt the password
    encrypted_password=$(encrypt_password "$password")

    # Ensure passwords.txt exists
    if [ ! -d "$SCRIPT_DIR/../assets" ]; then
        mkdir -p "$SCRIPT_DIR/../assets"
    fi
    if [ ! -f "$SCRIPT_DIR/../assets/passwords.txt" ]; then
        touch "$SCRIPT_DIR/../assets/passwords.txt"
    fi

    # Save the label and encrypted password to passwords.txt
    echo "$label:$encrypted_password" >> "$SCRIPT_DIR/../assets/passwords.txt"
    echo "Password stored successfully!"
}

# Function to retrieve a password
retrieve_password() {
    echo "Enter the label of the password you want to retrieve:"
    read label

    # Search for the label in passwords.txt
    line=$(grep "^$label:" "$SCRIPT_DIR/../assets/passwords.txt")
    
    if [ -n "$line" ]; then
        # Extract the encrypted password
        encrypted_password=$(echo "$line" | cut -d ':' -f2)
        
        # Decrypt the password
        decrypted_password=$(decrypt_password "$encrypted_password")
        echo "Password for $label: $decrypted_password"
    else
        echo "No password found for label: $label"
    fi
}

# Main menu
echo "Password Manager"
echo "1. Store a new password"
echo "2. Retrieve a password"
echo "3. Exit"

read choice

case $choice in
    1)
        store_password
        ;;
    2)
        retrieve_password
        ;;
    3)
        exit 0
        ;;
    *)
        echo "Invalid option."
        ;;
esac

