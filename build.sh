#!/bin/bash

CONTAINER_NAME=mud
IMAGE_NAME=circlemud
TAG=wip

# Cleanup old build resources
rm ./payloads/engine.tar.gz
rm ./payloads/world.tar.gz
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Package the engine and world payloads
cd ./payloads
tar -cf engine.tar circle
tar -cf world.tar lib
gzip engine.tar
gzip world.tar
cd ../

# Build the Docker image and run the container
docker build --tag $IMAGE_NAME:$TAG .
docker run --detach \
	--publish 4000:4000 \
	--volume /usr/circle/lib \
	--name $CONTAINER_NAME \
	circlemud:wip
