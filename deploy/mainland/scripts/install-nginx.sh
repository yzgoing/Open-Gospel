#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this script as root." >&2
  exit 1
fi

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <server_name> <ssl_certificate> <ssl_certificate_key>" >&2
  exit 1
fi

ROOT_DIR="${OPEN_GOSPEL_ROOT_DIR:-/opt/open-gospel}"
SERVER_NAME="$1"
SSL_CERTIFICATE="$2"
SSL_CERTIFICATE_KEY="$3"
TARGET_CONF="/etc/nginx/conf.d/open-gospel.conf"
TEMPLATE_PATH="${ROOT_DIR}/deploy/mainland/nginx/open-gospel.conf"

if [[ ! -f "${TEMPLATE_PATH}" ]]; then
  echo "Nginx template not found: ${TEMPLATE_PATH}" >&2
  exit 1
fi

python3 - <<'PY' "${TEMPLATE_PATH}" "${TARGET_CONF}" "${SERVER_NAME}" "${SSL_CERTIFICATE}" "${SSL_CERTIFICATE_KEY}"
from pathlib import Path
import sys

template_path = Path(sys.argv[1])
target_path = Path(sys.argv[2])
server_name = sys.argv[3]
ssl_certificate = sys.argv[4]
ssl_certificate_key = sys.argv[5]

content = template_path.read_text(encoding="utf-8")
content = content.replace("temple.example.com", server_name)
content = content.replace(
    "/etc/letsencrypt/live/temple.example.com/fullchain.pem",
    ssl_certificate,
)
content = content.replace(
    "/etc/letsencrypt/live/temple.example.com/privkey.pem",
    ssl_certificate_key,
)
target_path.write_text(content, encoding="utf-8")
PY

nginx -t
systemctl reload nginx

echo "Nginx config installed at ${TARGET_CONF}"
