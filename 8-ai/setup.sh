#!/bin/bash

# Start all services
docker compose up -d

# Pull qwen2.5:3b model
docker exec ollama ollama pull qwen2.5:3b

