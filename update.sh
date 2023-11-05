#!/bin/sh
git pull
docker compose down
docker build -t slonig-dev -f Containerfile .
docker compose up -d