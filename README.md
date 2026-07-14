# Ced's Platform

Infrastructure, automation, security standards, Docker deployments, ADRs, SOPs, and architecture documentation for Ced's platforms.

## Platforms

- Ced's HomeLab — infrastructure platform
- Synthos-01 — business platform
- Blockbuster-01 — media platform

## Repository layout

- `bootstrap/` — operating-system bootstrap automation
- `docker/` — Docker Compose definitions and templates
- `caddy/` — reverse-proxy configuration
- `security/` — hardening standards and scripts
- `monitoring/` — metrics, logs, and alerting configuration
- `netbird/` — private networking configuration and documentation
- `scripts/` — operational utilities
- `docs/ADR/` — architecture decision records
- `docs/SOP/` — standard operating procedures
- `docs/Architecture/` — platform architecture documentation

## Security

Secrets, passwords, API keys, certificates, `.env` files, and runtime application data must never be committed.
