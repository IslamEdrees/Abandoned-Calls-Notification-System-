#!/bin/bash

TELEGRAM_BOT_TOKEN="your_bot_token"
CHAT_ID="your_chat_id"
INPUT_FILE="/tmp/abandoned_numbers.txt"

if [[ ! -s "$INPUT_FILE" ]]; then
    echo " No new abandoned numbers to send."
    exit 0
fi

message=" Abandoned calls in the last hour:\n$(cat $INPUT_FILE)"
url="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

echo " Sending message to Telegram..."
response=$(curl -s -X POST "$url" -d "chat_id=$CHAT_ID" -d "text=$message")

echo "?? Telegram response: $response"

if echo "$response" | grep -q '"ok":true'; then
    echo " Message sent successfully!"
    rm -f "$INPUT_FILE"
else
    echo " Failed to send message!"
fi
