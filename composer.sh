#!/usr/bin/env bash

# Ensure that Docker is running...
if ! docker info > /dev/null 2>&1; then
	echo -e "Docker is not running." >&2

	exit 1
fi

USERID=$(id -u)
GROUPID=$(id -g)
COMPOSER_HOME=/tmp/composer
COMPOSER_CACHE_DIR=/.composer

# Run command
docker run --rm --interactive --tty \
	--env COMPOSER_HOME \
	--env COMPOSER_CACHE_DIR \
	--volume $HOME/.config/composer:$COMPOSER_HOME \
	--volume $HOME/.cache/composer:$COMPOSER_CACHE_DIR \
	--volume $PWD:/app \
	--workdir /app \
	composer:latest \
	/bin/sh -c "addgroup -g $GROUPID -S hostusr ; \
		adduser -u $USERID -s /bin/bash -D -S -G hostusr hostusr ; \
	 	chown -R hostusr:hostusr $COMPOSER_HOME ; \
	 	chown -R hostusr:hostusr $COMPOSER_CACHE_DIR ; \
		su - hostusr -c 'PATH=\$PATH:/usr/local/bin && cd /app && composer $1'"
