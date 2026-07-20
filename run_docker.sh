#!/bin/bash
set -euo pipefail

# Get absolute directory of script itself
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Default to "build" if no argument is provided
COMMAND=${1:-build}
IMAGE_NAME="riscv_tests_builder"

# Handle Podman vs Docker permissions
DOCKER_FLAGS=""
if [[ "$(docker --version 2>/dev/null)" == *"podman"* ]]; then
    echo "[Host] Using podman"
    DOCKER_FLAGS="--userns keep-id"
else
    echo "[Host] Using docker"
    DOCKER_FLAGS="--user $(id -u):$(id -g)"
fi

# Build the factory if it doesn't exist yet
if ! docker image inspect $IMAGE_NAME > /dev/null 2>&1; then
    echo "[Host] Building Docker image '$IMAGE_NAME'..."
    docker build -t $IMAGE_NAME "$DIR"
fi

echo "[Host] Spinning up container to execute: $COMMAND"

# Run the factory and mount the current directory
docker run \
    --rm \
    $DOCKER_FLAGS \
    -v "$DIR":/app:Z \
    $IMAGE_NAME $COMMAND