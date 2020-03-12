#!/bin/bash

git pull

mkdir /tmp
mkdir /tmp/cache
mkdir /tmp/certs
mkdir /tmp/pids

env $(cat .env | grep ^[A-Z] | xargs) docker stack deploy --compose-file docker-compose.yml test