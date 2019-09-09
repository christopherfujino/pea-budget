#!/bin/bash

set -euo pipefail

docker run \
  -it \
  --rm \
  --volume="$PWD:/home/budget-user/myapp" \
  --volume="$PWD/vendor:/usr/local/bundle" \
  -p 3000:3000 \
  christopherfujino/peas-budget-dev:latest \
  "$@"
