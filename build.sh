#!/bin/bash

# Build the support image
DOCKER_USERNAME="${DOCKER_USERNAME:-stedoh}"  # Set your Docker Hub username
IMAGE_NAME="my-support"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "Building Docker image: ${FULL_IMAGE_NAME}"
docker build -t "${IMAGE_NAME}:${TAG}" -t "${FULL_IMAGE_NAME}" .

if [ $? -eq 0 ]; then
    echo "✅ Image built successfully!"
    echo "Local tag: ${IMAGE_NAME}:${TAG}"
    echo "Docker Hub tag: ${FULL_IMAGE_NAME}"
    echo ""
    echo "To push to Docker Hub:"
    echo "1. docker login"
    echo "2. docker push ${FULL_IMAGE_NAME}"
    echo ""
    echo "Run with: docker run -it ${FULL_IMAGE_NAME}"
    echo "Run with volume mount: docker run -it -v \$(pwd):/workspace ${FULL_IMAGE_NAME}"
else
    echo "❌ Build failed!"
    exit 1
fi