# Telegram Server Side Notifier

A simple yet powerful Bash script that enables sending messages via multiple Telegram bots. This tool is perfect for lightweight automation, notifications, and integration into larger workflows. With an intuitive setup and multi-bot support, it’s designed to simplify communication in personal and professional environments.

## Features:

- Configure multiple Telegram bots using a single configuration file.
- Send messages directly from the command line with ease.
- Lightweight and reusable, making it ideal for integration into scripts and automation workflows.
- Customizable configuration file location for flexibility.

## Use Cases:

- Sending notifications from server scripts or cron jobs.
- Alerting in CI/CD pipelines or monitoring workflows.
- Lightweight communication for personal bots.

## Requirements

- `bash` (tested with version 5.1+)
- `curl`
- `jq` (for JSON processing)

---

## Installation

1. Download the bash script "telegram_bot.sh" via copy/paste, wget, or git clone.
   WGET
   ```bash
   wget https://github.com/ClairDeCoder/telegram_cli_notifier/blob/main/telegram_bot.sh
   ```
   GIT Clone
   ```bash
   git clone https://github.com/ClairDeCoder/telegram_cli_notifier.git
   cd telegram_cli_notifier
   ```
   
2. Copy the script to your preferred location (a current $PATH like the one used below is preferable):
   ```bash
   cp telegram_bot.sh /usr/local/bin/telegram_bot.sh
   chmod +x /usr/local/bin/telegram_bot.sh

*(Optional) Add the script to your PATH for easier usage.*

## Configuration

The script uses a configuration file to store bot details. By default, the configuration file is located at:
   ```bash
   ~/.telegram_bots
   ```
Each bot is stored in the format:
   ```bash
   bot_name|bot_token|chat_id
   ```

### Add Bots Using the Setup Command

Run the setup command to add a new bot:
   ```bash
   telegram_bot.sh setup
   ```

You’ll be prompted to enter:
   ```bash
   Bot Name: A unique identifier for the bot (e.g., bot1).
   Bot Token: The API token of your Telegram bot.
   Chat ID: The Telegram chat ID to send messages to.
   ```

Example:
   ```bash
   Enter bot name (e.g., bot1): bot1
   Enter Telegram Bot Token: ABC123:XYZTUV
   Enter Chat ID: 12345678
   ```

## Usage

Use the bot name to send a message:
   ```bash
   telegram_bot.sh <bot_name> <message>
   ```

Example:
   ```bash
   telegram_bot.sh bot1 "Hello, World!"
   ```

Incorporate this into other scripts or events management to alert you.

## Advanced Usage
Change Configuration File Location

By default, the configuration file is located at ~/.telegram_bots. To persistently change the configuration file location, you can define an environment variable in a configuration file like .bashrc or .zshrc.
Open your shell's configuration file (e.g., ~/.bashrc or ~/.zshrc).  
Add the following line:
   ```bash
   export TELEGRAM_BOTS_CONFIG="/path/to/custom_config"
   ```

Reload the shell or source the file:
   ```bash
   source ~/.bashrc
   ```

This will ensure the custom configuration file path is always used.

## Troubleshooting

Configuration File Not Found:
- Ensure the configuration file exists at the default location (~/.telegram_bots) or set the TELEGRAM_BOTS_CONFIG environment variable to the correct path.
- Run the setup command to create a new configuration file.

Invalid Bot Name:
- Verify that the bot name exists in the configuration file.
- Check the file format: bot_name|bot_token|chat_id.

Failed to Send Message:
- Ensure your bot token and chat ID are correct.
- Check the Telegram Bot [API status here](https://downforeveryoneorjustme.com/api.telegram.org).

## Example Configuration File

Example ~/.telegram_bots file:
   ```bash
   bot1|ABCDE:013912|-1003932013
   bot2|ZXWVN:039130|-1003093251
   ```

## License
Licensed under GNU 3.0 license.
