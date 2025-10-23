#!/bin/bash

# Push the support image to Docker Hub
DOCKER_USERNAME="${DOCKER_USERNAME:-stedoh}"  # Set your Docker Hub username
IMAGE_NAME="my-support"
TAG="latest"
FULL_IMAGE_NAME="${DOCKER_USERNAME}/${IMAGE_NAME}:${TAG}"

echo "=== Docker Hub Push Script ==="
echo "Image: ${FULL_IMAGE_NAME}"
echo ""

# Check if user is logged in
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker daemon not accessible"
    exit 1
fi

# Check if image exists locally
if ! docker image inspect "${FULL_IMAGE_NAME}" > /dev/null 2>&1; then
    echo "❌ Image ${FULL_IMAGE_NAME} not found locally"
    echo "Run './build.sh' first or set DOCKER_USERNAME environment variable"
    exit 1
fi

echo "📋 Image found locally: ${FULL_IMAGE_NAME}"
echo ""

# Login check (this will prompt if not logged in)
echo "🔐 Checking Docker Hub login..."
if ! docker info 2>/dev/null | grep -q "Username:"; then
    echo "Please login to Docker Hub:"
    docker login
    if [ $? -ne 0 ]; then
        echo "❌ Docker login failed"
        exit 1
    fi
fi

echo "✅ Docker login successful"
echo ""

# Push the image
echo "🚀 Pushing ${FULL_IMAGE_NAME} to Docker Hub..."
docker push "${FULL_IMAGE_NAME}"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to Docker Hub!"
    echo "🌐 Image available at: https://hub.docker.com/r/${DOCKER_USERNAME}/${IMAGE_NAME}"
    echo ""
    echo "Others can now pull with:"
    echo "docker pull ${FULL_IMAGE_NAME}"
else
    echo ""
    echo "❌ Push failed!"
    exit 1
fi