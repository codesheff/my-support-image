#!/bin/bash

set -euo pipefail

DOCKER_USERNAME="${DOCKER_USERNAME:-stedoh}"
IMAGE_NAME="my-support"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

WORKDIR_IN_CONTAINER="/workspace"
HOST_WORKDIR="${HOST_WORKDIR:-$(pwd)}"

echo "Running Docker image: ${FULL_IMAGE_NAME}"

docker run --rm -it \
  -v "${HOST_WORKDIR}:${WORKDIR_IN_CONTAINER}" \
  -w "${WORKDIR_IN_CONTAINER}" \
  "${FULL_IMAGE_NAME}" \
  /bin/bash
