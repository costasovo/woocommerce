#!/bin/bash
set -euo pipefail

# Script to prepare email-editor package for publishing to Packagist.org
# This script creates a build directory with the required structure and files

# Define paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PACKAGE_DIR/build"

echo "🚀 Preparing email-editor package for Packagist.org publishing..."

# Clean up existing build directory
if [ -d "$BUILD_DIR" ]; then
    echo "🧹 Cleaning up existing build directory..."
    rm -rf "$BUILD_DIR"
fi

# Create build directory structure
echo "📁 Creating build directory structure..."
mkdir -p "$BUILD_DIR/woocommerce/email-editor"

# Create mirrors.txt file
echo "📝 Creating mirrors.txt file..."
echo "woocommerce/email-editor" > "$BUILD_DIR/mirrors.txt"

# Copy required files and directories using rsync
echo "📋 Copying package files..."
rsync -av \
    --include='src/' \
    --include='src/**' \
    --include='composer.json' \
    --include='composer.lock' \
    --include='changelog.md' \
    --exclude='*' \
    "$PACKAGE_DIR/" \
    "$BUILD_DIR/woocommerce/email-editor/"

# Copy mirror-readme.md as README.md
echo "📝 Copying mirror-readme.md as README.md..."
cp "$PACKAGE_DIR/tasks/mirror-readme.md" "$BUILD_DIR/woocommerce/email-editor/README.md"

echo "✅ Build completed successfully!"

