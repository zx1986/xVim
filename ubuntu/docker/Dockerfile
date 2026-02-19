FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

# Install base dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    locales \
    sudo \
    fzf \
    build-essential \
    git \
    curl \
    wget \
    software-properties-common \
    python3 \
    python3-pip \
    python3-venv \
    ruby-full \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Python
RUN pip3 install pynvim

# Golang
RUN curl -fsSL https://go.dev/dl/go1.22.5.linux-amd64.tar.gz | tar -C /usr/local -xz

# Install LSP servers
RUN npm install -g pyright typescript-language-server typescript \
    && gem install solargraph \
    && go install golang.org/x/tools/gopls@latest

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

ENV PATH="~/.local/bin:/usr/local/go/bin:${PATH}"

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
