#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

echo $RAILS_MASTER_KEY
echo $MASTER_KEY

export RAILS_MASTER_KEY=$RAILS_MASTER_KEY
export MASTER_KEY=$MASTER_KEY

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"