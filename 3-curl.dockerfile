FROM alpine:latest

RUN apk add curl && \
    adduser -D curluser && \
    chown -R curluser:curluser /usr/bin/curl

USER curluser

ENTRYPOINT [ "curl" ]