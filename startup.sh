#!/bin/sh

export POSTGRES_DB=$POSTGRES_DB
export POSTGRES_USER=$POSTGRES_USER
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD

# Wait for the database
./wait-for-postgres.sh taco_db echo "Database is up!"

echo "*:*:*:*:$POSTGRES_PASSWORD" > ~/.pgpass

bundle exec rake db:exists && rake db:migrate || rake db:setup

bundle exec rake db:seed

mkdir tmp
mkdir tmp/pids

bundle exec yarn install --check-files

bundle exec rake assets:precompile

exec bundle exec puma -C config/puma.rb -b 'tcp://0.0.0.0:8080'
