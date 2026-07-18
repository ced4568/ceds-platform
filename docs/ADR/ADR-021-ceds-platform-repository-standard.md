---
title: ADR-021 - Standardize the Ced Platform Repository
status: Accepted
date: 07/18/2026
author: Chase Dumphord
owner: Ced's HomeLab
category: Architecture Decision Record
version: 1
tags:
  - adr
  - infrastructure-as-code
  - platform-engineering
  - git
  - bootstrap
  - docker
  - documentation
  - standards
review-date: 07/18/2027
related-documents:
  - ADR-020
  - SOP-core-01-bootstrap
  - core-01-architecture
---

# ADR-021 - Standardize the Ced Platform Repository

## Status

Accepted

---

## Executive Summary

Ced's Platform repository is being standardized as the authoritative
Infrastructure-as-Code source for Ced's HomeLab, Blockbuster-01, Synthos-01,
Fedora platform workstations, and future managed infrastructure.

The repository will use a consistent structure for operating-system bootstrap
automation, Docker Compose deployments, shared modules, security standards,
architecture documentation, ADRs, SOPs, and operational tooling.

Blockbuster-01 remains the initial example and reference server.

The core-01 implementation will formalize the shared repository standard and
become the first server built using reusable modules under
`bootstrap/common/`.

Existing working production deployments will not be moved or rewritten solely
to satisfy the new structure. Standardization will be introduced gradually
through controlled migrations, rebuilds, and significant maintenance events.

---

## Context

The `ceds-platform` repository began as a collection of bootstrap scripts,
Docker Compose files, and documentation created primarily while building
Blockbuster-01.

The repository currently supports or is expected to support:

- Ced's HomeLab
- core-01
- Blockbuster-01
- Synthos-01
- Additional Debian and Ubuntu servers
- Fedora platform engineering workstations
- Business application platforms
- Media platforms
- Observability platforms
- Future infrastructure systems

As additional servers and services are added, inconsistent implementation
patterns would create unnecessary maintenance and migration work.

Without a defined standard, the repository could develop inconsistent:

- Bootstrap procedures
- Directory layouts
- Docker Compose conventions
- Filesystem locations
- Package installation methods
- Security controls
- Validation methods
- Documentation practices
- Secret-management patterns
- Deployment workflows
- Backup procedures
- Recovery procedures

The platform requires a structure that is reusable across multiple operating
systems and server roles without assuming every system runs identical services.

The standard must also avoid breaking or unnecessarily reorganizing working
Blockbuster-01 deployments.

---

## Decision

The `ceds-platform` Git repository shall be the authoritative source of truth
for Ced's infrastructure configuration, automation, deployment definitions,
documentation, and platform standards.

The repository shall use shared bootstrap modules from the beginning.

Reusable functionality shall be stored under:

    bootstrap/common/

Host-specific bootstrap scripts shall source common modules instead of
duplicating equivalent logic.

Operating-system-specific and server-specific configuration shall remain inside
the appropriate host directory.

Existing production systems shall migrate toward the standard gradually.

Working production services shall not be moved, renamed, or rewritten solely
for cosmetic repository consistency.

---

## Repository Role

The repository shall contain the information required to:

- Understand the platform
- Reproduce servers
- Deploy services
- Validate installations
- Recover infrastructure
- Audit security decisions
- Document operational procedures
- Track architecture changes
- Maintain consistent standards

The repository shall not contain production secrets or runtime data.

---

## Repository Layout

The standard top-level layout shall be:

    ceds-platform/
    ├── bootstrap/
    ├── docker/
    ├── docs/
    ├── monitoring/
    ├── netbird/
    ├── scripts/
    ├── security/
    ├── .gitignore
    └── README.md

Additional top-level directories may be added when they represent a meaningful
and distinct platform function.

Empty directories do not need to be created solely to make the repository match
the documented structure.

---

## Bootstrap Architecture

Bootstrap automation shall be organized by shared functionality, operating
system, and host.

The approved bootstrap structure is:

    bootstrap/
    ├── common/
    │   ├── README.md
    │   ├── functions.sh
    │   ├── packages.sh
    │   ├── filesystem.sh
    │   ├── docker.sh
    │   └── validation.sh
    ├── debian/
    │   └── core-01/
    │       ├── README.md
    │       ├── 01-foundation.sh
    │       ├── 02-security.sh
    │       ├── 03-docker.sh
    │       ├── 04-netbird.sh
    │       └── 05-node-exporter.sh
    ├── ubuntu/
    │   ├── blockbuster-01/
    │   └── synthos-01/
    └── fedora/
        └── platform-workstation/

The `bootstrap/common/` directory shall be created and used during the
core-01 implementation.

It shall not remain an unused placeholder.

---

## Common Bootstrap Modules

### functions.sh

`functions.sh` shall provide shared shell utilities such as:

- Structured logging
- Error messages
- Warning messages
- Success messages
- Root and sudo validation
- Command-existence checks
- User validation
- Operating-system detection
- Distribution detection
- Safety checks
- Reusable confirmation helpers
- Error traps

### packages.sh

`packages.sh` shall provide reusable package-management functions such as:

- Package metadata refresh
- Package upgrades
- Baseline package installation
- Package-presence checks
- Debian package helpers
- Ubuntu package helpers
- Fedora package helpers when implemented
- Package validation

### filesystem.sh

`filesystem.sh` shall provide reusable filesystem functions such as:

- Creating standard platform directories
- Setting directory ownership
- Setting directory permissions
- Validating required paths
- Creating backup directories
- Creating log directories
- Creating script directories
- Creating Docker runtime directories

### docker.sh

`docker.sh` shall provide reusable Docker functions such as:

- Removing conflicting Docker packages
- Installing Docker repository prerequisites
- Configuring the official Docker repository
- Installing Docker Engine
- Installing Docker CLI
- Installing containerd
- Installing Docker Buildx
- Installing Docker Compose
- Enabling the Docker service
- Adding the administrative user to the Docker group
- Validating the Docker runtime
- Validating Docker Compose

### validation.sh

`validation.sh` shall provide reusable validation functions such as:

- Service-state validation
- Port-listener validation
- File validation
- Directory validation
- Ownership validation
- Docker runtime validation
- Docker Compose validation
- Firewall validation
- SSH configuration validation
- Swap validation
- Hostname validation
- Timezone validation

---

## Common Module Restrictions

Common modules must remain generic and reusable.

Common modules must not contain:

- Host-specific IP addresses
- Host-specific public domains
- Host-specific private domains
- Passwords
- Private keys
- API keys
- Access tokens
- Application credentials
- Production certificates
- Server-specific service inventories
- Production runtime data
- Hard-coded assumptions about one server

Host-specific values shall be defined in host scripts or approved configuration
files.

---

## Host Bootstrap Standards

Each managed host shall have a dedicated bootstrap directory under its
operating system.

Examples:

    bootstrap/debian/core-01/
    bootstrap/ubuntu/blockbuster-01/
    bootstrap/ubuntu/synthos-01/
    bootstrap/fedora/platform-workstation/

Each host directory shall contain a `README.md` that documents:

- Server role
- Operating system
- Hostname
- Administrative user
- Timezone
- Bootstrap order
- Required services
- Expected directories
- Known exceptions
- Security requirements
- Recovery considerations
- Validation procedures

Host bootstrap scripts shall use numbered execution phases.

The initial server bootstrap standard is:

    01-foundation.sh
    02-security.sh
    03-docker.sh
    04-netbird.sh
    05-node-exporter.sh

Additional numbered phases may be added when required.

Examples include:

    06-caddy.sh
    07-postgresql.sh
    08-redis.sh
    09-infisical.sh

Application deployment scripts do not have to be part of the base operating
system bootstrap when separating them improves safety and maintainability.

---

## Bootstrap Script Requirements

Bootstrap scripts shall:

- Use `#!/usr/bin/env bash`
- Use `set -Eeuo pipefail`
- Source required common modules
- Fail clearly when prerequisites are missing
- Avoid embedding secrets
- Validate results before reporting success
- Be idempotent where practical
- Preserve existing working configuration where practical
- Clearly identify destructive actions
- Use descriptive logging
- Stop when critical validation fails
- Avoid reporting false success

Host scripts may define values such as:

    HOST_NAME="core-01"
    STANDARD_USER="ced4568"
    TIMEZONE="America/Chicago"
    SWAP_SIZE="8G"

Reusable implementation logic shall remain in `bootstrap/common/`.

---

## Platform Uniformity

Uniformity means the supported platforms shall follow the same standards for:

- Repository organization
- Script structure
- Filesystem conventions
- Security principles
- Deployment patterns
- Compose conventions
- Secret handling
- Validation
- Documentation
- Backup planning
- Recovery planning

Uniformity does not mean every server must run identical services.

The platforms have different roles:

- Blockbuster-01 is the media platform and initial example server.
- core-01 is the Ced's HomeLab core infrastructure server.
- Synthos-01 is a business application platform.
- Fedora workstations are engineering client systems.

Shared standards shall support these different roles without forcing identical
workloads.

---

## Docker Repository Layout

Docker deployments shall continue to be grouped by functional category.

The approved layout is:

    docker/
    ├── applications/
    ├── backup/
    ├── infrastructure/
    ├── management/
    ├── media/
    └── observability/

This organization remains compatible with the current Blockbuster-01
repository structure.

Existing Docker deployment paths shall not be moved solely to introduce a new
naming scheme.

New categories may be added when a service does not logically belong in an
existing category.

---

## Docker Service Layout

Each Docker service should use the following structure where applicable:

    docker/<category>/<service>/
    ├── compose.yml
    ├── .env.example
    └── README.md

Additional tracked configuration may include:

    config/
    templates/
    scripts/
    dashboards/
    provisioning/

Not every service requires every file.

A service that requires no environment variables does not need an empty
`.env.example`.

A small service may use a concise README, while complex services should include
full deployment, validation, backup, and recovery instructions.

---

## Docker Compose Standards

Docker Compose deployments should use:

- Predictable service names
- Explicit container names only when operationally justified
- Named networks
- Named volumes or documented bind mounts
- Health checks where supported
- Restart policies
- Environment variables for configurable values
- Safe defaults
- Explicit timezone configuration where needed
- Version-controlled configuration templates
- No embedded production secrets

Compose filenames shall normally use:

    compose.yml

Existing deployments using:

    docker-compose.yml

do not have to be renamed until they are intentionally migrated or
significantly updated.

---

## Environment Variable Standards

Real `.env` files shall not be committed.

Services requiring environment variables shall include an `.env.example` file
containing:

- Required variable names
- Safe placeholders
- Comments where clarification is helpful
- No valid production passwords
- No valid API keys
- No valid tokens
- No private certificates

Example:

    POSTGRES_DB=change-me
    POSTGRES_USER=change-me
    POSTGRES_PASSWORD=replace-with-secret
    TZ=America/Chicago

Secrets shall eventually be managed through Infisical or another approved
secret-management platform.

Secret-manager adoption does not change the requirement that usable secrets
must never be committed to Git.

---

## Git Source-of-Truth Principle

The phrase:

> If it is not in Git, it does not exist.

applies to reproducible configuration, automation, and documentation.

It does not apply to secrets, runtime data, or generated application state.

The following should be stored in Git:

- Bootstrap scripts
- Docker Compose definitions
- Caddy configuration
- Configuration templates
- `.env.example` files
- Monitoring configuration
- Alerting configuration
- Dashboard definitions
- Architecture documentation
- ADRs
- SOPs
- Runbooks
- Deployment scripts
- Validation scripts
- Backup procedures
- Restore procedures
- Recovery instructions

The following must not be stored in Git:

- Private SSH keys
- Passwords
- API tokens
- Real `.env` files
- TLS private keys
- Database contents
- Docker volumes
- User uploads
- Application-generated state
- Production logs
- Cache data
- Session data
- Secret-manager recovery keys

---

## Server Filesystem Standards

Managed Linux servers should use the following standard paths:

    /opt/platform/ceds-platform
    /opt/docker
    /opt/backups
    /opt/scripts
    /opt/logs

The repository checkout shall normally reside at:

    /opt/platform/ceds-platform

Docker runtime deployments shall normally reside under:

    /opt/docker/<category>/<service>

The repository checkout and runtime deployment directory serve separate
purposes.

The Git repository contains:

- Version-controlled source configuration
- Templates
- Documentation
- Deployment definitions
- Validation logic

The `/opt/docker` tree contains:

- Active runtime configuration
- Local environment files
- Host-specific runtime files
- Service bind-mount directories
- References to application state

The Git repository itself shall not be used as the writable application data
directory.

Deployment automation should copy, synchronize, link, or render tracked
configuration from the repository into approved runtime paths.

The selected deployment method must be documented and consistently applied.

---

## Naming Standards

Hostnames shall use lowercase names with numeric suffixes where appropriate.

Examples:

    core-01
    blockbuster-01
    synthos-01
    dns01
    dns02

Repository directories shall use lowercase letters and hyphens.

Docker Compose service names shall be predictable and avoid unnecessary
abbreviations.

Script filenames shall be descriptive.

Numbered prefixes shall be used when execution sequence matters.

Public service hostnames shall use the approved domain for the platform.

Ced's HomeLab services shall use:

    *.cedshomelab.com

Business services shall use their approved business domain.

---

## Documentation Standards

Platform documentation shall be organized under:

    docs/
    ├── ADR/
    ├── Architecture/
    └── SOP/

Additional documentation categories may be added when required, including:

    docs/Runbooks/
    docs/Inventory/
    docs/Standards/
    docs/Implementation-Notes/

Documentation should use consistent metadata when maintained in Obsidian.

Recommended metadata includes:

- Title
- Status
- Date
- Author
- Owner
- Category
- Version
- Tags
- Review date
- Related documents

---

## Architecture Decision Records

ADRs shall document significant decisions involving:

- Platform architecture
- Technology selection
- Repository standards
- Security standards
- Networking standards
- Deployment standards
- Storage standards
- Backup standards
- Observability standards
- Authentication standards
- Major migrations

ADRs shall include at minimum:

- Title
- Status
- Date
- Context
- Decision
- Consequences

ADRs may additionally include:

- Executive Summary
- Architecture
- Alternatives Considered
- Security Considerations
- Migration Strategy
- Validation Requirements
- Review Schedule
- Related Documents

Accepted ADRs shall be committed to GitHub.

Obsidian may contain a synchronized or manually copied knowledge-base version,
but the Git repository remains the authoritative tracked version for platform
implementation.

---

## Standard Operating Procedures

SOPs shall document repeatable operational work such as:

- Initial deployments
- Upgrades
- Backups
- Restores
- Validation
- Incident response
- Credential rotation
- Secret rotation
- Certificate renewal
- Server replacement
- Disaster recovery
- Service migration
- Troubleshooting

SOPs shall contain copyable commands and clearly identify:

- Prerequisites
- Safety warnings
- Expected results
- Validation steps
- Rollback steps
- Recovery steps

---

## Architecture Documentation

Architecture documents shall explain:

- Server roles
- Service relationships
- Network paths
- Dependencies
- Data flows
- Security boundaries
- Authentication flows
- Secret flows
- Backup paths
- Recovery dependencies
- External access paths
- Monitoring and alerting paths

Major platform projects should include:

- An ADR
- An SOP
- Architecture documentation
- Implementation notes when useful

---

## Migration Strategy

Blockbuster-01 remains the initial example and reference implementation.

The core-01 implementation shall refine and formalize reusable platform
standards.

Changes introduced while building core-01 shall be evaluated for eventual
adoption across:

- Blockbuster-01
- Synthos-01
- Other Ubuntu servers
- Other Debian servers
- Fedora workstations where applicable

Existing production services shall not be moved or rewritten solely to satisfy
the new standard.

Migration shall occur when:

- A service is redeployed
- A server is rebuilt
- Significant maintenance is performed
- Existing configuration creates operational risk
- A platform-wide migration is intentionally planned
- A controlled migration is specifically approved

This approach prevents unnecessary work and reduces the likelihood of breaking
working production services.

---

## Backward Compatibility

Existing files and paths remain supported until intentionally migrated.

Examples include:

    bootstrap/ubuntu/server-bootstrap.sh
    bootstrap/ubuntu/blockbuster-baseline.sh
    docker/management/caddy/
    docker/media/
    docker/applications/

The introduction of shared modules shall not require immediate deletion or
movement of these files.

Legacy scripts may be:

- Retained temporarily
- Updated to call common modules
- Replaced during a controlled migration
- Marked as deprecated
- Removed only after replacement validation

Deprecation status shall be documented.

---

## Compatibility Policy

Shared modules must support intended operating systems without assuming Debian,
Ubuntu, and Fedora are identical.

Operating-system differences shall be handled through:

- Operating-system detection
- Distribution detection
- Distribution-specific package functions
- Host-specific variables
- Small distribution-specific wrapper functions
- Explicit compatibility checks

Common modules shall fail clearly when executed on an unsupported operating
system.

Common modules shall not silently apply an Ubuntu-specific procedure to Debian
or Fedora.

---

## Security Requirements

Infrastructure automation shall follow these requirements:

- SSH root login must not be disabled until administrative public-key access has
  been validated in a separate session.
- Password authentication must not be disabled until public-key access has been
  validated.
- UFW must not be enabled until an SSH allow rule exists.
- Firewall rules must be reviewed before enabling the firewall.
- Docker changes must be validated before production workloads are deployed.
- Existing production files must not be deleted without a verified backup.
- Secrets must never be printed into repository files.
- Secrets must never be committed.
- Private keys must remain protected with appropriate permissions.
- Destructive operations must be explicit.
- Critical operations must stop when validation fails.
- Security controls should be tested on one system before broad deployment.
- Host-specific exceptions must be documented.

---

## Validation Requirements

A bootstrap phase shall not report success until its critical outcomes have
been validated.

Validation may include:

- Correct hostname
- Correct timezone
- Administrative user exists
- Sudo access works
- SSH key authentication works
- SSH hardening settings are active
- Firewall rules are present
- Fail2Ban is active
- Swap is active
- Docker is active
- Docker Compose is available
- Required directories exist
- Ownership and permissions are correct
- NetBird is connected
- Node Exporter is listening
- Required ports are reachable

Validation output should clearly distinguish:

- Passed checks
- Warnings
- Failed checks
- Manual follow-up requirements

---

## Backup and Recovery Standards

Tracked configuration must be recoverable from GitHub.

Runtime data must be protected through approved backup systems.

The repository shall document:

- What is backed up
- Backup destination
- Backup frequency
- Retention policy
- Encryption requirements
- Restore procedure
- Restore validation
- Recovery dependencies

GitHub is not a replacement for database, volume, application-data, or secret
backups.

Secret-manager recovery material must be protected independently from the
secret-management platform itself.

---

## Alternatives Considered

### Continue with host-specific standalone scripts

This would allow each server to be developed independently.

It was rejected because it would create duplicated logic, inconsistent
standards, and additional maintenance work.

### Reorganize all existing files immediately

This would create immediate visual consistency.

It was rejected because it would introduce unnecessary migration work and risk
breaking working Blockbuster-01 deployments.

### Delay common modules until additional servers are built

This would reduce initial design effort.

It was rejected because duplication would begin immediately and later require
refactoring scripts that could have shared functionality from the start.

### Use one universal bootstrap script for every operating system

This would minimize the number of files.

It was rejected because Debian, Ubuntu, and Fedora have meaningful differences.
A single universal script would become difficult to understand, test, and
maintain.

---

## Consequences

### Benefits

- Shared code is used from the beginning.
- Duplicate bootstrap logic is reduced.
- Debian and Ubuntu systems follow the same platform model.
- Fedora systems can be added without disrupting Linux server automation.
- Host-specific scripts remain smaller and easier to understand.
- Blockbuster-01 and core-01 can evolve toward a uniform standard.
- New servers can be deployed more quickly.
- Disaster recovery becomes more predictable.
- Security controls become reusable.
- Validation becomes reusable.
- Documentation remains aligned with implementation.
- GitHub becomes a trustworthy platform source of truth.

### Trade-offs

- Common modules require careful design.
- Excessive abstraction must be avoided.
- Distribution differences must still be handled explicitly.
- Existing Blockbuster files will temporarily coexist with standardized files.
- Some migration work remains for future rebuilds and upgrades.
- Changes to common modules may affect multiple platforms.
- Shared-module changes require broader testing.
- GitHub and Obsidian copies must be kept synchronized.

These trade-offs are accepted.

---

## Implementation Plan

The standard shall be introduced in the following order:

1. Create and approve ADR-021.
2. Commit ADR-021 to the `feature/core-01-platform` branch.
3. Create `bootstrap/common/README.md`.
4. Create `bootstrap/common/functions.sh`.
5. Create `bootstrap/common/packages.sh`.
6. Create `bootstrap/common/filesystem.sh`.
7. Create `bootstrap/common/docker.sh`.
8. Create `bootstrap/common/validation.sh`.
9. Refactor the core-01 host scripts to use the common modules.
10. Validate the scripts against the current core-01 configuration.
11. Document the core-01 bootstrap SOP.
12. Document the core-01 architecture.
13. Evaluate the Blockbuster-01 scripts for controlled adoption of common
    modules.
14. Migrate other servers only through planned and validated changes.

---

## Review Criteria

This ADR shall be reviewed when:

- A new operating system is added
- A new server class is introduced
- Repository layout causes significant friction
- Common modules become difficult to maintain
- Deployment automation changes substantially
- Secret-management architecture changes
- GitOps automation is introduced
- A major platform rebuild occurs
- The scheduled review date is reached

---

## Final Decision

The Ced Platform repository shall adopt the standardized repository,
documentation, Docker, and bootstrap structure defined in this ADR.

The `bootstrap/common/` directory shall be created and used during the
core-01 implementation.

Reusable functionality shall be implemented once and consumed by
host-specific bootstrap scripts.

Blockbuster-01 remains the initial example and reference server.

core-01 becomes the first server built using the formalized shared bootstrap
standard.

Existing working deployments shall remain in place until a controlled migration
is justified, documented, backed up, and validated.
