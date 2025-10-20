#!/bin/bash

cat << EOF > init.sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);
EOF

# Create compose.yml
cat << EOF > compose.yml
services:
    postgres:
        container_name: postgres
        image: postgres:16.10-alpine
        ports:
            - 5432:5432
        volumes:
            - postgres-data:/var/lib/postgresql/data
            - ./init.sql:/docker-entrypoint-initdb.d/init.sql
        environment:
            - POSTGRES_DB=testdb
            - POSTGRES_USER=postgres
            - POSTGRES_PASSWORD=postgres

volumes:
    postgres-data: {}
EOF

docker compose -f compose.yml up -d