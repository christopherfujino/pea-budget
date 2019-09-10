#!/bin/bash

bundle install
yarn install

rm ./tmp/pids/server.pid

"$@"
