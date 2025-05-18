# Homelab Monitoring Stack

A Docker Compose based monitoring and logging stack with Prometheus, Grafana, Loki, and Promtail.

## Components

- **Caddy**: Reverse proxy that only exposes Grafana to the public (v2.7.6)
- **Prometheus**: Metrics collection and storage (v2.49.1)
- **Grafana**: Visualization and dashboarding (v10.2.3)
- **Loki**: Log aggregation system (v2.9.3)
- **Promtail**: Log collection agent (v2.9.3)

## Directory Structure

```
├── config
│   ├── caddy/Caddyfile
│   ├── grafana/provisioning/datasources/datasources.yml
│   ├── loki/loki-config.yml
│   ├── prometheus/prometheus.yml
│   └── promtail/promtail-config.yml
├── .env (credentials - not in git)
├── .env.example (template for credentials)
├── docker-compose.yml
└── Makefile (for common operations)
```

## Getting Started

1. Clone this repository
2. Initialize the setup:

```bash
make setup
```

3. Edit the `.env` file with your credentials
4. Start the stack:

```bash
make up
```

5. Access Grafana at http://grafana.localhost

## Common Operations

Use the included Makefile for common operations:

- `make up` - Start all services
- `make down` - Stop all services
- `make restart` - Restart all services
- `make logs` - View logs from all services
- `make clean` - Remove containers but preserve data
- `make prune` - Remove everything including data (use with caution!)
- `make help` - Show all available commands