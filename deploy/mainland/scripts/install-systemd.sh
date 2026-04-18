#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this script as root." >&2
  exit 1
fi

ROOT_DIR="${OPEN_GOSPEL_ROOT_DIR:-/opt/open-gospel}"
SERVICE_USER="${OPEN_GOSPEL_SERVICE_USER:-open-gospel}"
ENV_DIR="${OPEN_GOSPEL_ENV_DIR:-/etc/open-gospel}"
STATE_DIR="${OPEN_GOSPEL_STATE_DIR:-/var/lib/open-gospel}"
PYTHON_BIN="${PYTHON_BIN:-python3}"

if [[ ! -d "${ROOT_DIR}" ]]; then
  echo "Repository directory not found: ${ROOT_DIR}" >&2
  exit 1
fi

if ! id -u "${SERVICE_USER}" >/dev/null 2>&1; then
  useradd --system --home "${ROOT_DIR}" --shell /usr/sbin/nologin "${SERVICE_USER}"
fi

mkdir -p "${ENV_DIR}" "${STATE_DIR}"
cp "${ROOT_DIR}/deploy/mainland/.env.example" "${ENV_DIR}/open-gospel.env"
cp "${ROOT_DIR}/deploy/mainland/systemd/open-gospel.service" /etc/systemd/system/open-gospel.service

cd "${ROOT_DIR}"
"${PYTHON_BIN}" -m venv .venv
. .venv/bin/activate
pip install --upgrade pip
pip install .

chown -R "${SERVICE_USER}:${SERVICE_USER}" "${ROOT_DIR}/.venv" "${STATE_DIR}"

systemctl daemon-reload
systemctl enable --now open-gospel

echo "Open Gospel systemd service installed."
echo "Edit ${ENV_DIR}/open-gospel.env if needed, then run: systemctl restart open-gospel"
