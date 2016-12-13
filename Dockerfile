
FROM node:4

MAINTAINER arto.kaitosaari@gmail.com

# Update npm, gulp and spfx yeoman generator
RUN npm i -g npm && \
    npm i -g gulp yo @microsoft/generator-sharepoint && \
    npm cache clean \
    mkdir -p /var/spfx_precache

# Cache spfx dependencies 
WORKDIR /var/spfx_precache
ADD package.json .
RUN npm install --no-optional

# Start bash
CMD /bin/bash
