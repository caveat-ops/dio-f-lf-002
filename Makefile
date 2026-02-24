.PHONY: build up down restart bash logs logs-f test clean re ssl

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

restart:
	docker-compose restart

bash:
	docker exec -it apache-web-server bash

logs:
	docker logs apache-web-server

logs-f:
	docker logs -f apache-web-server

test:
	@echo "Testando servidor HTTP..."
	@curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost
	@curl -s -o /dev/null -w "Site1 Status: %{http_code}\n" http://site1.localhost
	@curl -s -o /dev/null -w "Site2 Status: %{http_code}\n" http://site2.localhost

clean:
	docker-compose down -v --rmi all
	rm -rf config/ssl/* logs/* 2>/dev/null || true
	rm -rf logs/apache2/* 2>/dev/null || true

re: clean build up

ssl:
	./scripts/ssl.sh
