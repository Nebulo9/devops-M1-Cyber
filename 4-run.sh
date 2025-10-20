#!/bin/bash
docker build -t broken-app -f 4-dev-app.dockerfile ./broken-app && \
    docker run --rm -p 3000:3000 broken-app