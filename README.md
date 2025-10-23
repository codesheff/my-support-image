# My Support Image

A comprehensive Docker container image with all the essential tools for development and operations work.

## Included Packages

### Basic Tools
- git, wget, curl, openssh-client
- glibc, libstdc++, libxkbfile, libsecret, procps, sudo
- tar, gzip, unzip
- vim, nano, less
- python3, python3-pip

### Network Tools
- net-tools, netcat, telnet
- dnsutils

### System Utilities
- openssl, jq
- which, gawk, sed, grep
- htop

### Cloud Tools
- **Google Cloud CLI (gcloud)** - Latest version
- **Helm** - Latest stable version

## Building the Image

```bash
# Using the build script
./build.sh

# Or manually
docker build -t my-support:latest .
```

## Running the Container

### Basic usage
```bash
docker run -it my-support:latest
```

### With volume mount (recommended)
```bash
docker run -it -v $(pwd):/workspace my-support:latest
```

### With specific working directory
```bash
docker run -it -v $(pwd):/workspace -w /workspace my-support:latest
```

## Features

- Based on Ubuntu 22.04 LTS for stability
- Non-root user setup with sudo privileges
- All packages installed and ready to use
- Optimized layers for efficient builds
- Clean package cache to minimize image size

## Usage Examples

### Google Cloud CLI
```bash
# Authenticate with gcloud
gcloud auth login

# Set project
gcloud config set project YOUR_PROJECT_ID
```

### Helm
```bash
# Add a helm repository
helm repo add stable https://charts.helm.sh/stable

# Install a chart
helm install my-release stable/nginx
```

### Development workflow
```bash
# Mount your project and work inside the container
docker run -it -v $(pwd):/workspace -w /workspace my-support:latest

# All your tools are available immediately
git status
python3 --version
gcloud version
helm version
```# my-support-image
