#!/bin/bash

# Export the DEBUG_MODE environment variable
export DEBUG_MODE=${DEBUG_MODE:-false}
echo "Starting supervisor with DEBUG_MODE=$DEBUG_MODE"

# Start supervisor
exec /usr/bin/supervisord -n