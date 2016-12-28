FROM ubuntu:12.04

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y build-essential git wget curl python && \
    mkdir /src && cd /src && \
    wget -c https://nodejs.org/dist/v0.10.33/node-v0.10.33.tar.gz && tar xvzf node-v0.10.33.tar.gz && \
    cd node-v0.10.33 && ./configure && make && make install && \
    npm i -g npm@latest-2 && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/* 

ENV DOCKERIZE_VERSION v0.3.0

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm -f dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
      chmod +x /usr/local/bin/dumb-init

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
