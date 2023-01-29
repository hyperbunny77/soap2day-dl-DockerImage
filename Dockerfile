FROM golang:bullseye
RUN apt update  && \
    apt-get install curl -y && \
    apt-get install -y && \
    apt-get install fzf -y && \
    apt-get install chromium -y && \
    apt-get install git -y && \
    apt-get install jq -y && \
    apt-get install aria2 -y
RUN go install github.com/ericchiang/pup@latest
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
# IMPORTANT: set the exact version
ENV NODE_VERSION v19.4.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH
RUN mkdir /app
RUN mkdir /downloads
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash
WORKDIR /app
RUN npm i puppeteer-core puppeteer puppeteer-extra puppeteer-extra-plugin-stealth
ADD . /app
