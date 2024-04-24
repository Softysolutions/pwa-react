# syntax = docker/dockerfile:1

#! BASE ####################################################
FROM node:slim as base

## Optional because user node exist in this imagecreate
## create a non-root user for security 
## RUN useradd -m -s /bin/bash react

## Setting up the work directory
WORKDIR /home/node/app

## Exposing server port
EXPOSE 3000





#! DEVBASE ################################################
FROM base as devbase

## Install dev tools
RUN apt update && apt-get -y --no-install-recommends install nano zsh curl tmux git ca-certificates

## Add admin user
RUN useradd admin && \
    echo "admin:admin" | chpasswd && \
    apt-get update && \
    apt-get -y --no-install-recommends install sudo && \
    echo "admin ALL=(ALL) ALL" >> /etc/sudoers

## Clear cache
RUN rm -rf /var/lib/apt/lists/*

## Install Oh My Zsh for user node
USER node
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN touch ~/.zshrc && \
    sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -e 's/plugins=(git)/plugins=(git)/' ~/.zshrc && \
    echo 'export PATH="$PATH:/home/rails/.local/bin"' >> ~/.zshrc

CMD ["/bin/zsh"]






#? DEVELOPMENT ############################################
## Fetching the minified node image on apline linux
FROM devbase as development

## Declaring env
ENV NODE_ENV development

## Copy package file
USER root
COPY package.json package-lock.json ./
RUN chmod ugo+rwx package-lock.json
RUN chown -R node:node ./
USER node

## Installing dependencies
RUN npm install

## Copy application code
COPY . .

## Starting our application
## CMD [ "nodemon", "index.js" ]
## CMD [ "node", "index.js" ]





#? TEST ####################################################
## Use an official Node.js runtime as the base image
FROM devbase as test

## Install make (if needed)
RUN apt-get update && apt-get install -y make

## Declaring env
ENV NODE_ENV test

## Copy package file
USER root
COPY package.json package-lock.json ./
RUN chmod ugo+rwx package-lock.json
RUN chown -R node:node ./
USER node

## Installing dependencies for running tests
RUN npm install
RUN npm install --save-test mocha chai chai-http

## Copy application code
COPY . .

## Run your tests using a command (e.g., Mocha or Jest)
## CMD ["npm", "test"]





#* PRODUCTION ###############################################
## Fetching the minified node image on apline linux
FROM base as production

## Declaring env
ENV NODE_ENV production

## Copy package file
USER root
COPY package.json package-lock.json ./
RUN chmod ugo+rwx package-lock.json
RUN chown -R node:node ./
USER node

## Installing dependencies
RUN npm install --production

## Copy application code
COPY . .

## Build the React app for production
RUN npm run build

## Use a lightweight web server to serve the production build
RUN npm install -g serve

## Serve the production build
CMD ["serve", "-s", "build", "-l", "3000"]

