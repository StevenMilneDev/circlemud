#!/bin/bash

CONTAINER_NAME=mud
IMAGE_NAME=circlemud
TAG=wip

# Cleanup old build resources
docker kill $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Build the Docker image and run the container
docker build --tag $IMAGE_NAME:$TAG .
docker run --detach \
	--publish 4000:4000 \
	--volume /usr/circle/lib \
	--name $CONTAINER_NAME \
	$IMAGE_NAME:$TAG
