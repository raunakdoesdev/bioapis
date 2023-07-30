# Variables
EXTENSION_NAME = "beta"# must be lowercase
DOCKER_IMAGE = ${EXTENSION_NAME}:latest
PORT = 8166
JUPYTER_PORT = 18166

# Phony targets
.PHONY: docker docker-build docker-run

# Default target
all: docker

# Docker target: build and run Docker image
docker: docker-build docker-run

# Docker build target: builds Docker image
docker-build:
	@echo "Substituting PLACEHOLDER_EXTENSION_NAME with $(EXTENSION_NAME) in Dockerfile"
	sed "s/ENV EXTENSION_NAME=.*/ENV EXTENSION_NAME=$(EXTENSION_NAME)/g" Dockerfile > Dockerfile.tmp
	mv Dockerfile.tmp Dockerfile
	sed "s/ENV JUPYTER_PORT=.*/ENV JUPYTER_PORT=$(JUPYTER_PORT)/g" Dockerfile > Dockerfile.tmp
	mv Dockerfile.tmp Dockerfile
	@echo "Building Docker image $(DOCKER_IMAGE)"
	docker build -t $(DOCKER_IMAGE) .

# Docker run target: runs Docker container
docker-run:
	@echo "Running Docker container $(DOCKER_IMAGE)"
	@echo "Open http://localhost:$(PORT) in your browser"
	@echo "Open http://localhost:$(JUPYTER_PORT) in your browser for the Jupyter notebook"
	docker run -it  -p $(PORT):80 -p $(JUPYTER_PORT):$(JUPYTER_PORT) -v $(shell pwd):/app $(DOCKER_IMAGE)

# Docker exec target: opens a bash terminal inside of a running container for this image
docker-exec:
	@echo "Docker container id: $(shell docker ps -aqf "ancestor=$(DOCKER_IMAGE)")"
	docker exec -it $(shell docker ps -aqf "ancestor=$(DOCKER_IMAGE)") /bin/bash

# Docker stop target: stops a running container for this image
docker-stop:
	@echo "Docker container id: $(shell docker ps -aqf "ancestor=$(DOCKER_IMAGE)")"
	docker stop $(shell docker ps -aqf "ancestor=$(DOCKER_IMAGE)")
