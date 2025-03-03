# Abandoned Calls Notification System

## Overview
This project automates the process of extracting abandoned call data from a database and sending notifications to a Telegram group. It consists of two main scripts:
1. **Data Extraction Script:** Runs on the database server to fetch abandoned calls from the last hour.
2. **Notification Script:** Runs on a central server with internet access to send the extracted data to Telegram.

## Project Components
- **Database Server**: Hosts the call data and executes the extraction script.
- **Central Server**: Receives the extracted data and sends it to Telegram.
- **Telegram Bot**: Sends notifications to a specified chat group.

## Technologies Used
- **Bash Scripting**: For automation and task execution.
- **MySQL**: To retrieve call records from the database.
- **SSH & SCP**: Securely transfers data between servers.
- **Cron Jobs**: Automates script execution.
- **Telegram Bot API**: Sends notifications to a chat group.

## How It Works
1. **Data Extraction**
   - A Bash script runs every hour on the database server.
   - It queries the database for abandoned calls in the last hour.
   - The retrieved numbers are saved in a text file.
   - The file is securely transferred to the central server.

2. **Notification Sending**
   - A separate script on the central server processes the received file.
   - It formats the data into a message.
   - The message is sent to the Telegram group using the bot API.

## Deployment Steps
1. **Setup SSH Authentication**
   - Ensure passwordless SSH authentication between the database and central server.

2. **Install Required Packages**
   ```bash
   sudo apt update && sudo apt install mysql-client curl
   ```

3. **Configure Cron Jobs**
   - On the database server:
     ```bash
     crontab -e
     0 * * * * /path/to/extraction_script.sh >> /var/log/extraction.log 2>&1
     ```
   - On the central server:
     ```bash
     crontab -e
     5 * * * * /path/to/notification_script.sh >> /var/log/notification.log 2>&1
     ```

## Testing
1. Run the extraction script manually:
   ```bash
   bash /path/to/extraction_script.sh
   ```
   Check if the data file is created and transferred.
2. Run the notification script manually:
   ```bash
   bash /path/to/notification_script.sh
   ```
   Verify that the message is sent successfully to Telegram.
