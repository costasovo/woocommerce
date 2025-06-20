#!/bin/bash

# Script to clean up specified files and directories from a given path
# Usage: ./mirror_cleanup.sh <directory_path>

# Check if a directory path was provided
if [ $# -eq 0 ]; then
    echo "Error: No directory path provided"
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Get the directory path from the first argument
TARGET_DIR="$1"

# Check if the directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

# List of files and directories to delete
ITEMS_TO_DELETE=(
    "node_modules"
    "tasks"
    "changelog"
    "tests"
    "vendor"
    ".wp-env.json"
    "package.json"
	"phpcs.xml"
	"development.md"
	"phpunit.xml.dist"
	"phpunit-integration.xml.dist"
	"writing-tests.md"
	.lintstagerc.json
)

echo "Cleaning up directory: $TARGET_DIR"
echo ""

# Loop through each item to delete
for item in "${ITEMS_TO_DELETE[@]}"; do
    item_path="$TARGET_DIR/$item"

    if [ -e "$item_path" ]; then
        if [ -d "$item_path" ]; then
            echo "Removing directory: $item"
            rm -rf "$item_path"
        else
            echo "Removing file: $item"
            rm -f "$item_path"
        fi
    else
        echo "Skipping: $item (not found)"
    fi
done

echo ""
echo "Cleanup completed."
