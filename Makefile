.PHONY: test_dev test_prod

test_dev:
	docker network create traefik || true
	docker-compose -f docker-compose.yml up --build --force-recreate --no-deps -d
	./scripts/is_running.sh adr_traefik_1 || exit 1
	docker-compose -f docker-compose.yml down --remove-orphans
	docker network rm traefik

test_prod:
	docker network create traefik || true
	docker-compose -f docker-compose.prod.yml up --build --force-recreate --no-deps -d
	./scripts/is_running.sh adr_traefik_1 || exit 1
	docker-compose -f docker-compose.prod.yml down --remove-orphans
	docker network rm traefik