#!/bin/bash

# Default to kiosk mode if no argument provided
MODE=${1:-kiosk}

docker stop watchparty > /dev/null 2>&1
docker rm -f watchparty > /dev/null 2>&1
docker build -t watchparty .

if [ "$MODE" = "debug" ]; then
    echo "Starting in DEBUG mode..."
    docker run -d \
        --name watchparty \
        --shm-size=5g \
        -p 5900:5900 \
        -p 6080:6080 \
        -p 8080:8080 \
        -v wp-data:/data/chrome \
        -e DEBUG_MODE=true \
        watchparty
    # Show logs to verify mode
    sleep 2
else
    echo "Starting in KIOSK mode..."
    docker run -d \
        --name watchparty \
        --shm-size=5g \
        -p 5900:5900 \
        -p 6080:6080 \
        -p 8080:8080 \
        -v wp-data:/data/chrome \
        watchparty
fi