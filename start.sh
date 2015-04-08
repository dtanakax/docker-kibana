#!/bin/bash
set -e

sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://$ELASTICSEARCH_PORT_9200_TCP_ADDR:$ELASTICSEARCH_PORT_9200_TCP_PORT\"|" /opt/kibana/config/kibana.yml

# Executing
exec /opt/kibana/bin/kibana