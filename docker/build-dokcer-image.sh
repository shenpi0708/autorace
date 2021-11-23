#!/usr/bin/env bash

# Get script path
file_dir=$(dirname $0)

# Get parameter from system
user=$(id -un)
group=$(id -gn)
uid=$(id -u)
gid=$(id -g)

# Docker image name
DOCKER_IMAGE_NAME=autorace
# Docker container name
DOCKER_CONTAINER_NAME=autorace

# Build docker images
docker build --rm -t autorace \
    --build-arg USER=${user} \
    --build-arg UID=${uid} \
    --build-arg GROUP=${group} \
    --build-arg GID=${gid} \
    ${file_dir}