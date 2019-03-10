#!/bin/bash

NAME=circlemud
VERSION=1.0.0-empty

IMAGE=$NAME
PORT=4000
TAG=$VERSION
VOLUME=/usr/circle/lib

# Cleanup old build resources
docker kill $NAME
docker rm $NAME

if [ -z "$1" ]; then
	VOLUME=circle-world:$VOLUME
elif [ "$1" = "shell" ]; then
	docker build --tag $IMAGE:$TAG .
	docker run \
		--interactive \
		--tty \
		--publish 4000:4000 \
		--name circlemud \
		circlemud:1.0.0 \
		/bin/bash
		exit
elif [ "$1" = "dev" ]; then
	# If initial state not populated then populate it now
	if [ ! -a ./state/etc/players ]; then
		cp -r ./circle/lib/* ./state/
	fi

	TAG=$VERSION-dev
	VOLUME=$(pwd)/state:$VOLUME
fi

docker build --tag $IMAGE:$TAG .
docker run --detach \
	--publish $PORT:4000 \
	--volume $VOLUME \
	--name $NAME \
	$IMAGE:$TAG
