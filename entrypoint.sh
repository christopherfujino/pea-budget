#!/bin/bash

bundle install
yarn install

bundle exec rails webpacker:install

"$@"
