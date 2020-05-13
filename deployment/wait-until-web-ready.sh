#!/bin/bash

URL="http://host.docker.internal:3000"

until $(curl --output /dev/null --silent --head --fail $URL); do
    printf "waiting for $URL to come online... trying again in 5 seconds.\n"
    sleep 5
done

printf "reached $URL successfully!\n"
