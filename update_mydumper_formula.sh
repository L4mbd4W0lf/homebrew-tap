#!/bin/bash

# Exit instantly if any command fails
set -euo pipefail

# Configuration
FORMULA_PATH="Formula/mydumper.rb"

# 1. Capture the input argument
TARGET_URL="${1:-}"

if [ -z "${TARGET_URL:-}" ]; then
    echo "❌ Error: Please provide the target MyDumper source archive URL."
    echo "Usage: $0 https://github.com"
    exit 1
fi

if [ ! -f "$FORMULA_PATH" ]; then
    echo "❌ Error: Cannot find formula file at standard location: $FORMULA_PATH"
    echo "Make sure you are executing this script from the root of your local tap directory."
    exit 1
fi

echo "📥 Fetching archive and calculating SHA256 hash..."
NEW_HASH=$(curl --fail --location --silent --show-error "$TARGET_URL" | shasum -a 256 | awk '{print $1}')

if [ -z "$NEW_HASH" ] || [ ${#NEW_HASH} -ne 64 ]; then
    echo "❌ Error: Failed to generate a valid 64-character SHA256 signature from the link."
    exit 1
fi

echo "✅ Generated Hash: $NEW_HASH"
echo "⚙️ Injecting updates into $FORMULA_PATH..."

# Use python to modify the text inline safely on macOS without string matching breaking
python3 - "$FORMULA_PATH" "$TARGET_URL" "$NEW_HASH" <<'PY'
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
url = sys.argv[2]
sha = sys.argv[3]
tag_match = re.search(r"/refs/tags/v?([^/]+)\.(?:tar\.gz|tgz|zip)$", url)
if not tag_match:
    raise SystemExit("URL must be a tagged archive ending in .tar.gz, .tgz, or .zip")
version = tag_match.group(1)
content = path.read_text()
content, url_count = re.subn(r'(?m)^  url "[^"]+"$', f'  url "{url}"', content)
content, sha_count = re.subn(r'(?m)^  sha256 "[^"]+"$', f'  sha256 "{sha}"', content)
content, version_count = re.subn(r'(?m)^  version "[^"]+"$', f'  version "{version}"', content)
if url_count != 1 or sha_count != 1 or version_count != 1:
    raise SystemExit("Expected exactly one url, version, and sha256 line in the formula")
path.write_text(content)
PY

echo "🔎 Verifying Homebrew formula syntax..."
brew audit --strict --online "$FORMULA_PATH"

echo -e "\n======================================================="
echo "🎉 Update successful! Ready for commit and push."
echo "Review your local tracking diff with: git diff"
echo "======================================================="

