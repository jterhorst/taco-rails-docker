#!/bin/sh

export POSTGRES_DB=$POSTGRES_DB
export POSTGRES_USER=$POSTGRES_USER
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD

# Wait for the database
./wait-for-postgres.sh taco_db echo "Database is up!"

./startup_prepare.sh

ifconfig lo0 alias 123.123.123.123/24

exec bundle exec puma -C config/puma.rb -b 'tcp://0.0.0.0:3000'
