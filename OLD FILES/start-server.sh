#!/bin/bash
echo "=== SKAFFACITY UNITY SERVER STARTUP ==="
echo "Startup time: $(date)"
echo "Working directory: $(pwd)"

# Export minimal required environment variables for Unity server
echo "Setting up minimal environment variables..."

# Only export essential variables - configuration comes from API
export MASTER_SERVER_URL="${MASTER_SERVER_URL:-https://panel.lvlagency.nl:25566}"
export SERVER_PORT="${SERVER_PORT:-7001}"

# Unity-specific environment variables
export UNITY_HEADLESS=true
export UNITY_BATCHMODE=true

echo "Environment Configuration:"
echo "- Master Server: $MASTER_SERVER_URL" 
echo "- Server Port: $SERVER_PORT"
echo "- Configuration: Loaded via API endpoints"

# Auto-detect executable
if [ -f "SkaffaCityServer" ]; then
    SERVER_EXEC="./SkaffaCityServer"
    echo "Found executable: SkaffaCityServer"
elif [ -f "SkaffaCityServer.x86_64" ]; then
    SERVER_EXEC="./SkaffaCityServer.x86_64" 
    echo "Found executable: SkaffaCityServer.x86_64"
else
    echo "ERROR: No Unity server executable found!"
    echo "Looking for: SkaffaCityServer or SkaffaCityServer.x86_64"
    exit 1
fi

# Set executable permissions
chmod +x "${SERVER_EXEC#./}"

echo "=========================================="
echo "🚀 Starting SkaffaCity Unity Server..."
echo "🌐 Configuration via API endpoints"
echo "📡 Server registration and heartbeat enabled"
echo "🔧 Minimal environment variables - Maximum flexibility"
echo "=========================================="

# Launch Unity server (reads configuration from environment variables only)
exec $SERVER_EXEC -batchmode -nographics $@
