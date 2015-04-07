#!/bin/bash
set -e

sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://$ES_PORT_9200_TCP_ADDR:$ES_PORT_9200_TCP_PORT\"|" /opt/kibana/config/kibana.yml

# Executing
/opt/kibana/bin/kibana