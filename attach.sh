#!/bin/bash

CONTAINER_NAME=$(docker container ls --format "{{.Names}}" | grep '^peas-budget_web')

docker attach "$CONTAINER_NAME"
