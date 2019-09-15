#!/bin/bash

set -euo pipefail

USER_ID=$(id -u)
GROUP_ID=$(id -g)
IMAGE_NAME='christopherfujino/peas-budget-dev'

docker build \
  --build-arg USER_ID="$USER_ID" \
  --build-arg GROUP_ID="$GROUP_ID" \
  -t "$IMAGE_NAME:latest" \
  -t "$IMAGE_NAME:$(date '+%Y-%m-%d_%H%M')" \
  .
