# core-01 Bootstrap

Bootstrap automation and implementation notes for `core-01`.

## Server role

`core-01` is the core infrastructure server for Ced's HomeLab.

It hosts shared infrastructure and management services such as:

- Caddy
- PostgreSQL
- Redis
- Infisical
- Authentik
- Uptime Kuma
- Dozzle
- Node Exporter
- NetBird

It is not a media server.

## Operating system

- Debian 13
- Hostname: `core-01`
- Timezone: `America/Chicago`
- Administrative user: `ced4568`

## Bootstrap order

1. Operating-system foundation
2. SSH and firewall security
3. Docker Engine and Compose
4. NetBird
5. Node Exporter
6. Caddy
7. PostgreSQL
8. Redis
9. Infisical
10. Uptime Kuma and Dozzle
11. Authentik
12. Hermes services

## Scripts

- `01-foundation.sh` — hostname, timezone, administrative user, packages, and updates
- `02-security.sh` — swap, SSH hardening, UFW, and Fail2Ban
- `03-docker.sh` — Docker repository, Docker Engine, Compose, and platform directories

## Safety rules

- Scripts must be idempotent where practical.
- Secrets must never be committed.
- SSH root login must not be disabled until key-based access for `ced4568` has been separately validated.
- UFW must not be enabled until an SSH allow rule exists.
- Existing production deployments must not be moved solely to match a new repository convention.
- Infrastructure changes must be validated before applying the same change to other servers.
