#!/bin/bash

# Fetch the latest stable Zig version from GitHub API
ZIG_VERSION=$(curl -s https://api.github.com/repos/ziglang/zig/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Define the download URL
ZIG_DOWNLOAD_URL="https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)

# Download and extract Zig
curl -L $ZIG_DOWNLOAD_URL | tar -xJ -C $TEMP_DIR

# Move the Zig binary to /usr/local/bin
sudo mv $TEMP_DIR/zig-linux-x86_64-$ZIG_VERSION/zig /usr/local/bin/zig

# Clean up the temporary directory
rm -rf $TEMP_DIR

# Verify installation
zig version
