#!/bin/bash
set -e

if [ "$1" = "/opt/kibana/bin/kibana" ]; then
    sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://elasticsearch:9200\"|" /opt/kibana/config/kibana.yml
fi

exec "$@"