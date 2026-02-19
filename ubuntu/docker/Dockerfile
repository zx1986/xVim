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
    golang-go \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18 (apt nodejs on Ubuntu 22.04 is v12, too old for typescript-language-server)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install terraform-ls (HashiCorp apt repo)
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y terraform-ls \
    && rm -rf /var/lib/apt/lists/*

# Install LSP servers
RUN pip3 install pynvim
RUN npm install -g pyright typescript-language-server typescript yaml-language-server
RUN gem install solargraph --no-document
RUN go install golang.org/x/tools/gopls@v0.11.0 \
    && cp -v /root/go/bin/gopls /usr/local/bin/

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
