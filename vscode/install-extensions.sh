#!/bin/bash

# Check if a file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <extensions-file>"
    exit 1
fi

EXTENSIONS_FILE="$1"

# Check if the file exists
if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "Error: File '$EXTENSIONS_FILE' not found."
    exit 1
fi

# Install each extension listed in the file
while IFS= read -r extension || [ -n "$extension" ]; do
    if [[ -n "$extension" && ! "$extension" =~ ^# ]]; then
        echo "Installing extension: $extension"
        code --install-extension "$extension" || {
            echo "Failed to install extension: $extension"
        }
    fi
done < "$EXTENSIONS_FILE"

echo "All extensions processed."
