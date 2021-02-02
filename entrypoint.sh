#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /mycontentful/tmp/pids/server.pid

rails db:setup && rails db:test:prepare && rails assets:precompile

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"