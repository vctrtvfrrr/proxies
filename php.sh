#!/usr/bin/env bash

# Ensure that Docker is running...
if ! docker info > /dev/null 2>&1; then
	echo -e "${WHITE}Docker is not running.${NC}" >&2

	exit 1
fi

# Run command
docker run --rm -it -v $(pwd):/app -w /app php:latest php $1
