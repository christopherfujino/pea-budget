#!/bin/bash

bundle install
yarn install

"$@"
