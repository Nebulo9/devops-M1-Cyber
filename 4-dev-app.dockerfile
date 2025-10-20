FROM node:current-alpine

RUN adduser -D nodeuser

COPY ./broken-app /home/nodeuser/app

WORKDIR /home/nodeuser/app

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "node", "server.js" ]