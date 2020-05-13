#!/bin/bash

until $(curl --output /dev/null --silent --head --fail $CYPRESS_BASE_URL); do
    printf "waiting for $CYPRESS_BASE_URL to come online... trying again in 5 seconds.\n"
    sleep 5
done

printf "reached $CYPRESS_BASE_URL successfully!\n"
