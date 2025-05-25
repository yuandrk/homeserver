# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a Docker Compose-based monitoring and logging stack for a homelab environment, featuring:

- Caddy (v2.7.6): Reverse proxy that only exposes Grafana publicly
- Prometheus (v2.49.1): Metrics collection and storage
- Grafana (v10.2.3): Visualization and dashboarding
- Loki (v2.9.3): Log aggregation system
- Promtail (v2.9.3): Log collection agent

## Common Commands

### Setup and Deployment

```bash
# Initialize the setup (creates config directories and copies .env.example to .env if needed)
make setup

# Start all services
make up

# Stop all services
make down

# Restart all services
make restart

# View logs from all services
make logs

# Remove containers while preserving data volumes
make clean

# Remove everything including data volumes (destructive)
make prune

# Display all available commands
make help
```

### Configuration Files

- **Caddy**: `/config/caddy/Caddyfile`
- **Prometheus**: `/config/prometheus/prometheus.yml`
- **Loki**: `/config/loki/loki-config.yml`
- **Promtail**: `/config/promtail/promtail-config.yml`
- **Grafana**: 
  - Datasources: `/config/grafana/provisioning/datasources/datasources.yml`
  - Dashboards: `/config/grafana/provisioning/dashboards/`

## Architecture Notes

1. **Security Model**:
   - Only Grafana is exposed to the public through Caddy reverse proxy
   - Prometheus, Loki, and other services are only accessible internally
   - Credentials are stored in `.env` file (not committed to git)

2. **Data Flow**:
   - Promtail collects logs from system and Docker containers
   - Logs are sent to Loki for storage and indexing
   - Prometheus collects metrics from various services
   - Grafana visualizes both logs (Loki) and metrics (Prometheus)

3. **Configuration Structure**:
   - Each service has its own configuration directory under `/config`
   - Containers use volume mounts to access these configurations
   - Data persistence is managed through named Docker volumes

4. **Docker Best Practices**:
   - Specific version tags for all containers
   - Read-only volume mounts where possible 
   - Container healthchecks for monitoring
   - Proper logging configuration with rotation
   - Non-root user for Prometheus
   - Named volumes for persistent data

5. **Access Points**:
   - Grafana UI: http://grafana.localhost
   - Default credentials are in .env file (admin/admin by default)