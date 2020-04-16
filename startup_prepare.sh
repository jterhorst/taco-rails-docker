#!/bin/sh

echo "*:*:*:*:$POSTGRES_PASSWORD" > ~/.pgpass

bundle exec rake db:exists && rake db:migrate || rake db:setup

bundle exec rake db:seed

mkdir tmp
mkdir tmp/pids

bundle exec yarn install --check-files

bundle exec rake assets:precompile
