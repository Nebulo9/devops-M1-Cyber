#!/bin/bash

cat << EOF > .env
DB_PORT=5432
DB_HOST=postgres
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=microservices
REDIS_HOST=redis
REDIS_PORT=6379
EOF


cat << EOF > compose.yml
services:
    postgres:
        image: postgres:16-alpine
        environment:
            POSTGRES_USER: postgres
            POSTGRES_PASSWORD: postgres
            POSTGRES_DB: microservices
        volumes:
            - postgres-data:/var/lib/postgresql/data
        healthcheck:
            test: ["CMD-SHELL", "pg_isready -U postgres"]
            interval: 10s
            timeout: 5s
            retries: 5
        
    redis:
        image: redis:alpine
        healthcheck:
            test: ["CMD", "redis-cli", "ping"]
            interval: 10s
            timeout: 5s
            retries: 5

    worker:
        build: ./microservices-app/worker
        env_file:
            - .env
        depends_on:
            postgres:
                condition: service_healthy
            redis:
                condition: service_healthy

    api:
        build: ./microservices-app/api
        ports:
            - "4000:4000"
        env_file:
            - .env
        depends_on:
            - worker

networks:
    microservices-network:
        driver: bridge

volumes:
    postgres-data: {}
EOF

docker compose -f compose.yml up