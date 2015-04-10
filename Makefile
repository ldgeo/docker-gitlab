all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the gitlab image"
	@echo "   2. make quickstart   - start gitlab"
	@echo "   3. make stop         - stop gitlab"
	@echo "   4. make logs         - view logs"
	@echo "   5. make purge        - stop and remove the container"

build:
	@docker build --tag=oslandia/gitlab-oslandia .

quickstart:
	@echo "Starting gitlab..."
	@docker run --name='gitlab-oslandia' -d \
		-e 'GITLAB_PORT=10080' -e 'GITLAB_SSH_PORT=10022' \
		-p 10022:22 -p 10080:80 \
		-v /var/run/docker.sock:/run/docker.sock \
		-v $(shell which docker):/bin/docker \
		oslandia/gitlab-oslandia:latest >/dev/null
	@echo "Please be patient. This could take a while..."
	@echo "GitLab will be available at http://localhost:10080"
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping gitlab..."
	@docker stop gitlab-oslandia >/dev/null

purge: stop
	@echo "Removing stopped container..."
	@docker rm gitlab-oslandia >/dev/null

logs:
	@docker logs -f gitlab-oslandia
