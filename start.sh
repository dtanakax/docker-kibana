#!/bin/bash
set -e

sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://$ES_PORT_9200_TCP_ADDR:$ES_PORT_9200_TCP_PORT\"|
        s|^host: \"0.0.0.0\"|host: \"localhost\"|" /opt/kibana/config/kibana.yml

# Executing supervisord
supervisord -n