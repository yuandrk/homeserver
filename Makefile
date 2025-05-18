.PHONY: up down restart logs clean prune setup help

help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Create necessary configuration files
	@echo "Creating config directories..."
	@mkdir -p config/{caddy,prometheus,loki,promtail,grafana/provisioning/{datasources,dashboards}}
	@[ ! -f .env ] && cp .env.example .env || echo ".env already exists"

up: ## Start all services
	@echo "Starting services..."
	@docker compose up -d

down: ## Stop all services
	@echo "Stopping services..."
	@docker compose down

restart: ## Restart all services
	@echo "Restarting services..."
	@docker compose restart

logs: ## View logs from all services
	@docker compose logs -f

clean: ## Remove all containers and networks, preserving volumes
	@echo "Cleaning up containers and networks..."
	@docker compose down

prune: ## Remove all containers, networks AND volumes (DANGER: Deletes all data)
	@echo "WARNING: This will delete ALL data (volumes). Press Ctrl+C to cancel, or Enter to continue."
	@read
	@echo "Pruning everything..."
	@docker compose down -v