#!/bin/bash

# Fetch the latest stable Zls version from GitHub API
ZLS_VERSION=$(curl -s https://api.github.com/repos/zigtools/zls/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Define the download URL
ZLS_DOWNLOAD_URL="https://github.com/zigtools/zls/releases/download/${ZLS_VERSION}/zls-x86_64-linux.tar.xz"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)

# Download and extract Zls
curl -L $ZLS_DOWNLOAD_URL | tar -xJ -C $TEMP_DIR

# Move the Zls binary to /usr/local/bin
sudo ln -s $TEMP_DIR/zls /usr/local/bin/zls

# Verify installation
zls --version