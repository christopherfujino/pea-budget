#!/bin/bash

set -euo pipefail

USER_ID=$(id -u)
GROUP_ID=$(id -g)

docker build \
  --build-arg USER_ID="$USER_ID" \
  --build-arg GROUP_ID="$GROUP_ID" \
  -t christopherfujino/peas-budget-dev:latest \
  .
