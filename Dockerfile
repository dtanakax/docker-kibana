# Set the base image
FROM tanaka0323/debianjp:wheezy

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_VERSION 4.0.2

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get clean all

RUN curl -k https://download.elasticsearch.org/kibana/kibana/kibana-$KIBANA_VERSION-linux-x64.tar.gz >> kibana.tar.gz && \
    tar zxvf kibana.tar.gz && \
    mv -f /kibana-$KIBANA_VERSION-linux-x64 /opt/kibana && \
    rm -f kibana.tar.gz

# Adding the configuration file
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Define mountable directories.
VOLUME ["/opt/kibana/config"]

# Set the port to 5601
EXPOSE 5601

# Executing sh
ENTRYPOINT ./start.sh