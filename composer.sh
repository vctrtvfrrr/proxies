#!/usr/bin/env bash

# Ensure that Docker is running...
if ! docker info > /dev/null 2>&1; then
	echo -e "Docker is not running." >&2

	exit 1
fi

COMPOSER_HOME=/tmp

# Run command
docker run --rm --interactive --tty \
  --env COMPOSER_HOME \
  --volume ${COMPOSER_HOME:-$HOME/.config/composer}:$COMPOSER_HOME \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  --workdir /app \
  composer $1
