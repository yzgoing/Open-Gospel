#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${DEPLOY_DIR}"

if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "Created ${DEPLOY_DIR}/.env from template. Review it before exposing the node publicly."
fi

docker compose up -d --build
docker compose ps

echo "Local health check:"
curl --fail http://127.0.0.1:8080/healthz
