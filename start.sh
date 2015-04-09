#!/bin/bash
set -e

sed -i "s|^elasticsearch_url:.*|elasticsearch_url: \"http://elasticsearch:9200\"|
        s|^# ssl_key_file:.*|ssl_key_file: /opt/kibana/certs/kibana.key|
        s|^# ssl_cert_file:.*|ssl_cert_file: /opt/kibana/certs/kibana.crt|" /opt/kibana/config/kibana.yml

# Executing
exec /opt/kibana/bin/kibana