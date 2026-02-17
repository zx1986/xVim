FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

# Install minimal dependencies for testing
RUN apt-get update && apt-get install -y \
    ca-certificates \
    locales \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create non-root user for realistic testing
RUN useradd -m -s /bin/bash -G sudo testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to testuser
USER testuser
WORKDIR /home/testuser

# Create necessary directories
RUN mkdir -p /home/testuser/.config/nvim \
             /home/testuser/.local/share/nvim \
             /home/testuser/workspace

# Set working directory
WORKDIR /home/testuser/workspace

# Default command
CMD ["/bin/bash"]
