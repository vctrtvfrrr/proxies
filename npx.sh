#!/usr/bin/env bash

# Ensure that Docker is running...
if ! docker info > /dev/null 2>&1; then
	echo -e "Docker is not running." >&2

	exit 1
fi

# Run command
docker run --rm --interactive --tty \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  --workdir /app \
  node:latest \
  npx $1
