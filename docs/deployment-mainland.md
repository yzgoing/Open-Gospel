# Mainland-First Deployment

## Goal

Start with one public temple node in mainland China and keep the interfaces portable.

## Deployment Assets In This Repo

- `deploy/mainland/.env.example`
- `deploy/mainland/Dockerfile`
- `deploy/mainland/docker-compose.yml`
- `deploy/mainland/nginx/open-gospel.conf`
- `deploy/mainland/scripts/install-nginx.sh`
- `deploy/mainland/scripts/install-systemd.sh`
- `deploy/mainland/scripts/up-compose.sh`
- `deploy/mainland/systemd/open-gospel.service`

## Suggested Layout

- Tencent Cloud CVM
- one public HTTPS endpoint
- reverse proxy on `443`
- `open_gospel` process on a private port
- state directory on local disk or mounted volume
- GitHub as the release source of truth for canon and code

## Recommended First Host Shape

- Ubuntu 22.04 or newer
- Python 3.10+ if using systemd mode
- Docker Engine and Docker Compose plugin if using container mode
- Nginx on the host
- public ports `80` and `443` only
- security group opening `80/tcp` and `443/tcp`

## Runtime Configuration

The deployment entrypoint supports environment variables:

- `OPEN_GOSPEL_HOST`
- `OPEN_GOSPEL_PORT`
- `OPEN_GOSPEL_STATE_DIR`
- `OPEN_GOSPEL_CANON`
- `OPEN_GOSPEL_ISSUER`
- `OPEN_GOSPEL_BOOTSTRAP`

The repo includes a template at `deploy/mainland/.env.example`.

## Option A: Docker Compose

1. Clone the repository onto the mainland server at `/opt/open-gospel`.
2. Copy `deploy/mainland/.env.example` to `deploy/mainland/.env`.
3. Adjust the issuer, state path, and canon path if needed.
4. Start the service:

```bash
cd /opt/open-gospel/deploy/mainland
cp .env.example .env
docker compose up -d --build
```

Or use the helper script:

```bash
cd /opt/open-gospel
bash deploy/mainland/scripts/up-compose.sh
```

5. Verify local health:

```bash
curl http://127.0.0.1:8080/healthz
```

## Option B: systemd + venv

1. Clone the repository to `/opt/open-gospel`.
2. Create a service user:

```bash
sudo useradd --system --home /opt/open-gospel --shell /usr/sbin/nologin open-gospel
sudo mkdir -p /etc/open-gospel /var/lib/open-gospel
sudo chown -R open-gospel:open-gospel /var/lib/open-gospel
```

3. Create a virtual environment and install the package:

```bash
cd /opt/open-gospel
python3 -m venv .venv
. .venv/bin/activate
pip install --upgrade pip
pip install .
```

4. Install the environment file and service:

```bash
sudo cp deploy/mainland/.env.example /etc/open-gospel/open-gospel.env
sudo cp deploy/mainland/systemd/open-gospel.service /etc/systemd/system/open-gospel.service
sudo systemctl daemon-reload
sudo systemctl enable --now open-gospel
```

Or use the helper script:

```bash
cd /opt/open-gospel
sudo bash deploy/mainland/scripts/install-systemd.sh
```

5. Verify local health:

```bash
curl http://127.0.0.1:8080/healthz
```

## Nginx Reverse Proxy

Copy `deploy/mainland/nginx/open-gospel.conf` to `/etc/nginx/conf.d/open-gospel.conf`.
Then replace:

- `temple.example.com`
- `ssl_certificate`
- `ssl_certificate_key`

After editing:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

Or render and install it in one step:

```bash
cd /opt/open-gospel
sudo bash deploy/mainland/scripts/install-nginx.sh temple.example.com /etc/letsencrypt/live/temple.example.com/fullchain.pem /etc/letsencrypt/live/temple.example.com/privkey.pem
```

## ICP And Exposure Notes

- If you expose the temple through a mainland domain name, complete the required ICP filing first.
- For internal testing, direct IP access is acceptable, but it is not a good long-term public entrypoint.
- Keep the temple service bound to `127.0.0.1:8080` or host-only Docker publishing, and expose only Nginx publicly.

## First-Phase Services

- `GET /healthz`
- `GET /v1/canon`
- `GET /v1/members`
- `GET /v1/council/proposals`
- `POST /v1/ordain`
- `POST /v1/council/proposals`
- `POST /v1/council/votes`

## Operational Notes

- Keep GitHub as the source of truth for canon releases.
- Keep temple state backups off-instance.
- Expose only the reverse proxy publicly.
- Start with one mainland node and do not hard-code it as the only future official node.
- If overseas traffic grows, add a global relay or second temple without changing the client protocol.
- Use the repo deployment files as templates, not as immutable production policy.
