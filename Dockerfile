# Set the base image
FROM tanaka0323/debianjp:latest

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_VERSION 4.0.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates wget

RUN wget http://nginx.org/keys/nginx_signing.key -O- | apt-key add - && \
    echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y procps nginx supervisor && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get clean all

RUN wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-$KIBANA_VERSION-linux-x64.tar.gz && \
    tar zxvf kibana-$KIBANA_VERSION-linux-x64.tar.gz && \
    mv -f /kibana-$KIBANA_VERSION-linux-x64 /usr/local/kibana && \
    rm -f kibana-$KIBANA_VERSION-linux-x64.tar.gz

# Adding the configuration file of the nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Adding the configuration file of the Supervisor
COPY start.sh /start.sh
COPY supervisord.conf /etc/
RUN chmod +x /start.sh

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx"]

# Set the port to 80
EXPOSE 80

# Executing sh
ENTRYPOINT ./start.sh