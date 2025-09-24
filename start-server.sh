#!/bin/bash
echo "Starting SkaffaCity Server..."

# Default configuration
PORT=7001
MAX_PLAYERS=50
MASTER_URL="http://207.180.235.41:3000"
SERVER_ID="server-$(date +%s)"

# Override with environment variables if provided
if [ ! -z "$SKAFFA_SERVER_PORT" ]; then
    PORT=$SKAFFA_SERVER_PORT
fi

if [ ! -z "$SKAFFA_MAX_PLAYERS" ]; then
    MAX_PLAYERS=$SKAFFA_MAX_PLAYERS
fi

if [ ! -z "$SKAFFA_MASTER_URL" ]; then
    MASTER_URL=$SKAFFA_MASTER_URL
fi

if [ ! -z "$SKAFFA_SERVER_ID" ]; then
    SERVER_ID=$SKAFFA_SERVER_ID
fi

# Set Unity environment variables
export UNITY_HEADLESS=true
export UNITY_BATCHMODE=true

echo "Server Configuration:"
echo "- Port: $PORT"
echo "- Max Players: $MAX_PLAYERS"
echo "- Master URL: $MASTER_URL"
echo "- Server ID: $SERVER_ID"

# Launch server
./SkaffaCityServer -batchmode -nographics -port $PORT -maxplayers $MAX_PLAYERS -serverid $SERVER_ID -masterurl "$MASTER_URL" $@
