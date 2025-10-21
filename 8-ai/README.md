# LibreChat setup with Ollama and Context7 MCP server

This project aims to setup local LLM agents using Ollama and chat with them with a fancy Web UI such as LibreChat.

## Prerequisties

* [Docker]()
* cURL

## Project architecture
```
.
├── README.md
├── .env
├── compose.yml
├── compose.override.yml
└── setup.sh
```

## Setup

To start this project just run:

```shell
bash setup.sh
```

This script pulls the original `docker-compose.yml`and the `.env.example` from the LibreChat [repo](), respectevily as `compose.yml` and `.env` and the change the port value to access the Web UI from `3080` to `3000`. The script will then start all the required services using Docker Compose considering both `compose.yaml` and `compose.override.yaml` files (see [Docker Compose override]()).
Once all the services are created and started, the Web UI is available at `http://127.0.0.1:3000`

### LibreChat

