#!/bin/bash
DB_HOST="your_db_host"
DB_USER="your_db_user"
DB_NAME="your_db_name"
OUTPUT_FILE="/tmp/abandoned_numbers.txt"
CENTRAL_SERVER="your_central_server"
CENTRAL_USER="your_user"
SSH_PORT=your_ssh_port

start_time=$(date --date='1 hour ago' +"%Y-%m-%d %H:00:00")
end_time=$(date +"%Y-%m-%d %H:00:00")

echo " Extracting abandoned calls from $start_time to $end_time..."

QUERY="SELECT ANI FROM datamart_queue_details WHERE queue='your_queue_name' AND event_time >= '$start_time' AND event_time < '$end_time' AND event='abandoned';"

mysql -h "$DB_HOST" -u "$DB_USER" -D "$DB_NAME" -se "$QUERY" > "$OUTPUT_FILE"

if [[ -s "$OUTPUT_FILE" ]]; then
    echo " Abandoned numbers found, sending to central server..."
    
    scp -P "$SSH_PORT" -o StrictHostKeyChecking=no "$OUTPUT_FILE" ${CENTRAL_USER}@${CENTRAL_SERVER}:/tmp/abandoned_numbers.txt
    
    if [[ $? -eq 0 ]]; then
        echo " File sent successfully!"
    else
        echo " Failed to send the file!"
    fi
else
    echo " No abandoned calls found."
fi
