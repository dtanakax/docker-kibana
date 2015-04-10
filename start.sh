#!/bin/bash
set -e

sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://elasticsearch:9200\"|" /opt/kibana/config/kibana.yml

# Executing
exec /opt/kibana/bin/kibana