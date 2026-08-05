#!/bin/sh
set -e

# Default values if environment variables are not set
export ICECAST_SOURCE_PASSWORD="${ICECAST_SOURCE_PASSWORD:-hackme_source}"
export ICECAST_ADMIN_PASSWORD="${ICECAST_ADMIN_PASSWORD:-hackme_admin}"
export ICECAST_ADMIN_USERNAME="${ICECAST_ADMIN_USERNAME:-admin}"
export ICECAST_RELAY_PASSWORD="${ICECAST_RELAY_PASSWORD:-hackme_relay}"
export ICECAST_PORT="${PORT:-8000}"
export ICECAST_LOCATION="${ICECAST_LOCATION:-Render Cloud Server}"
export ICECAST_ADMIN_EMAIL="${ICECAST_ADMIN_EMAIL:-admin@localhost}"
export ICECAST_HOSTNAME="${ICECAST_HOSTNAME:-localhost}"

# Generate final icecast.xml replacing placeholders
envsubst < /etc/icecast2/icecast.xml.template > /etc/icecast2/icecast.xml

# Set strict permissions required by Icecast (600) and ownership
chown -R icecast:icecast /var/log/icecast /etc/icecast2
chmod 600 /etc/icecast2/icecast.xml

echo "Starting Icecast2 on port ${ICECAST_PORT}..."
exec su-exec icecast icecast -c /etc/icecast2/icecast.xml
