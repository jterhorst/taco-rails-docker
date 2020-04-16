#!/bin/sh

export POSTGRES_DB=$POSTGRES_DB
export POSTGRES_USER=$POSTGRES_USER
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD

# Wait for the database
./wait-for-postgres.sh taco_db echo "Database is up!"

./startup_prepare.sh

exec bundle exec puma -C config/puma.rb -b 'tcp://0.0.0.0:8080'
