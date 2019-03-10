#!/bin/bash

NAME=circlemud
VERSION=1.0.0

IMAGE=$NAME
PORT=4000
TAG=$VERSION
VOLUME=/usr/circle/lib

# Cleanup old build resources
docker kill $NAME
docker rm $NAME

if [ "$1" = "dev" ]; then
	# Create bind-mount area
	cp ./payloads/circle/lib/* ./state
	TAG=$VERSION-dev
	VOLUME=$(pwd)/state:$VOLUME
fi

docker build --tag $IMAGE:$TAG .
docker run --detach \
	--publish $PORT:4000 \
	--volume $VOLUME \
	--name $NAME \
	$IMAGE:$TAG
