#!/bin/bash

# Telegram Multi-Bot Messaging Script

# Use the TELEGRAM_BOTS_CONFIG environment variable if set, otherwise default to ~/.telegram_bots
CONFIG_FILE="${TELEGRAM_BOTS_CONFIG:-${HOME}/.telegram_bots}"

# Function to send a message using the specified bot
send_message() {
    local bot_name="$1"
    local message="$2"

    # Check if configuration file exists
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "Error: Configuration file '$CONFIG_FILE' not found. Please run setup first."
        exit 1
    fi

    # Extract bot details from the configuration file
    local bot_details
    bot_details=$(grep "^$bot_name|" "$CONFIG_FILE")

    if [[ -z "$bot_details" ]]; then
        echo "Error: Bot '$bot_name' not found in configuration file."
        exit 1
    fi

    # Parse bot token and chat ID
    local bot_token
    local chat_id
    bot_token=$(echo "$bot_details" | cut -d'|' -f2)
    chat_id=$(echo "$bot_details" | cut -d'|' -f3)

    if [[ -z "$bot_token" || -z "$chat_id" ]]; then
        echo "Error: Incomplete details for bot '$bot_name'."
        exit 1
    fi

    # URL encode the message
    local encoded_message
    encoded_message=$(echo "$message" | jq -sRr @uri)

    # Send the message
    local response
    response=$(curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
        -d "chat_id=$chat_id&text=$encoded_message")

    if [[ "$(echo "$response" | jq -r '.ok')" != "true" ]]; then
        echo "Failed to send message: $(echo "$response" | jq -r '.description')"
    else
        echo "Message sent successfully via bot '$bot_name'."
    fi
}

# Setup function to add new bots
setup_bot() {
    echo "Setting up a new bot..."
    read -p "Enter bot name (e.g., bot1): " bot_name
    read -p "Enter Telegram Bot Token: " bot_token
    read -p "Enter Chat ID: " chat_id

    # Validate inputs
    if [[ -z "$bot_name" || -z "$bot_token" || -z "$chat_id" ]]; then
        echo "Error: All fields are required."
        exit 1
    fi

    # Ensure configuration file exists
    touch "$CONFIG_FILE"

    # Check if the bot name already exists
    if grep -q "^$bot_name|" "$CONFIG_FILE"; then
        echo "Error: Bot '$bot_name' already exists in configuration file."
        exit 1
    fi

    # Add the bot to the configuration file
    echo "$bot_name|$bot_token|$chat_id" >> "$CONFIG_FILE"
    echo "Bot '$bot_name' added successfully."
}

# Main function
main() {
    case "$1" in
        "setup")
            setup_bot
            ;;
        *)
            if [[ $# -lt 2 ]]; then
                echo "Usage: $0 {setup|<bot_name> <message>}"
                exit 1
            fi
            send_message "$1" "$2"
            ;;
    esac
}

main "$@"
