# Set the base image
FROM dtanakax/debianjp:wheezy

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, dtanakax@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_VERSION 4.1.1

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

ENTRYPOINT ["./start.sh"]

# Set the port to 5601
EXPOSE 5601

CMD ["/opt/kibana/bin/kibana"]
