#!/bin/bash

bundle install
bundle exec annotate
yarn install

PID_FILE='./tmp/pids/server.pid'
if [ -f "$PID_FILE" ]; then
  rm "$PID_FILE"
fi

"$@"
