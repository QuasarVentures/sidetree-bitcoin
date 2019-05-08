FROM node:8-slim

WORKDIR /app

# Installation Dependencies
RUN apt-get update && \
    apt-get install -y \
    g++ \
    libzmq3-dev \
    make \
    python

#COPY ./bitcored-services ./

RUN npm install bitcore -g --unsafe-perm=true
EXPOSE 3001 3002 3232 9999 19999

# create node
RUN bitcore create bitcore-sidetree-node --testnet
WORKDIR /app/bitcore-sidetree-node

RUN bitcore install insight-api insight-ui

# Purge Dependencies
RUN apt-get purge -y \
  g++ make python gcc && \
  apt-get autoclean && \
  apt-get autoremove -y

#RUN npm uninstall -g bitcore

# Setup Node
#RUN npm config set package-lock false && \
#  npm install

#RUN ls -la ./node_modules/.bin
#RUN cat ./node_modules/.bin/bitcored

RUN ls -la
RUN ls -la
RUN ls -la data
RUN cat bitcore-node.json



#apt-get install python libzmq3-dev build-essential



#COPY ./package.json /app
#COPY ./package-lock.json /app
#WORKDIR /app
#
#EXPOSE 3009
HEALTHCHECK --interval=5s --timeout=5s --retries=10 CMD curl -f http://localhost:3001/insight/

ENTRYPOINT [ "bitcored" ]

VOLUME /app/bitcore-sidetree-node/data
