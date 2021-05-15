.PHONY: test

test:
	docker network create traefik || true
	docker-compose -f docker-compose.test.yml up --build --force-recreate --no-deps -d
	./scripts/is_running.sh adr_traefik_1 || exit 1
	docker-compose -f docker-compose.test.yml down --remove-orphans
	docker network rm traefik