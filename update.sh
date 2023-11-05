#!/bin/sh
git pull
cargo build --release
docker compose down
DOCKER_BUILDKIT=1 docker build -t slonig-dev -f Containerfile .
docker compose up -d