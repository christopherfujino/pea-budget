#!/bin/bash

CONTAINER_NAME=$(docker container ls --format "{{.Names}}" | grep '^pea-budget_rails')

docker attach "$CONTAINER_NAME"
