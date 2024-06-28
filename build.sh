#!/bin/bash

# Variables
IMAGE_NAME="gl1312bc"
USERNAME="vincinator"
PLATFORMS=("linux/amd64" "linux/arm64")
TAG_AMD64="ghcr.io/$USERNAME/$IMAGE_NAME:amd64"
TAG_ARM64="ghcr.io/$USERNAME/$IMAGE_NAME:arm64"
TAG_LATEST="ghcr.io/$USERNAME/$IMAGE_NAME:latest"

# Log in to GitHub Container Registry
echo "Logging in to GitHub Container Registry..."
#podman login ghcr.io

# Build and push images for both architectures
for PLATFORM in "${PLATFORMS[@]}"; do
    echo "Building image for $PLATFORM..."
    if [ "$PLATFORM" == "linux/amd64" ]; then
	JOB_HOST_GNU_TYPE_PACKAGE="x86-64-linux-gnu"
	JOB_HOST_ARCH="amd64"
        TAG=$TAG_AMD64
    else
	JOB_HOST_GNU_TYPE_PACKAGE="aarch64-linux-gnu"
	JOB_HOST_ARCH="arm64"
        TAG=$TAG_ARM64
    fi

    podman build --platform $PLATFORM -t $TAG --build-arg JOB_HOST_GNU_TYPE_PACKAGE=$JOB_HOST_GNU_TYPE_PACKAGE --build-arg JOB_HOST_ARCH=$JOB_HOST_ARCH .
    podman push $TAG
done

# Create and push the manifest
echo "Creating and pushing the manifest..."
podman manifest create $TAG_LATEST
podman manifest add $TAG_LATEST $TAG_AMD64
podman manifest add $TAG_LATEST $TAG_ARM64
podman manifest push $TAG_LATEST


echo "Done!"

