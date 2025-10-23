# Use a stable base image
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Update package lists and install basic packages
RUN apt-get update && apt-get install -y \
    # Basic networking and development tools
    git \
    wget \
    curl \
    openssh-client \
    # Core libraries
    libc6 \
    libstdc++6 \
    libxkbfile1 \
    libsecret-1-0 \
    procps \
    sudo \
    # Archive tools
    tar \
    gzip \
    unzip \
    # Text editors
    vim \
    nano \
    less \
    # Python
    python3 \
    python3-pip \
    # Network utilities
    net-tools \
    netcat \
    telnet \
    # Security
    openssl \
    # JSON processor
    jq \
    # DNS utilities
    dnsutils \
    # System utilities
    gawk \
    sed \
    grep \
    # Process monitoring
    htop \
    # Additional useful packages
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Install Google Cloud CLI
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update \
    && apt-get install -y google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*

# Install Helm using the official installation script
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Create a non-root user
RUN useradd -m -s /bin/bash -G sudo user \
    && echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set working directory
WORKDIR /home/user

# Switch to non-root user
USER user

# Set default command
CMD ["/bin/bash"]