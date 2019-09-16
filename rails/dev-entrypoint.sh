#!/bin/bash

bundle install
yarn install

PID_FILE='./tmp/pids/server.pid'
if [ -f "$PID_FILE" ]; then
  rm "$PID_FILE"
fi

"$@"
