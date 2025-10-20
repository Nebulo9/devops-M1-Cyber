FROM node:current-alpine

RUN adduser -D nodeuser

COPY . /app

WORKDIR /app

RUN chown -R nodeuser:nodeuser /app && \
    chmod -R 755 /app

USER nodeuser

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "node", "server.js" ]