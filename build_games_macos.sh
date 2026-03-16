#!/bin/sh
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
GAMES_DIR="$ROOT_DIR/samples/games"
OSCAR64_BIN="$ROOT_DIR/build/Release/oscar64"

if [ ! -x "$OSCAR64_BIN" ]; then
  if [ -x "$ROOT_DIR/build_macos.sh" ]; then
    "$ROOT_DIR/build_macos.sh"
  else
    echo "oscar64 not found. Run build_macos.sh first."
    exit 1
  fi
fi

# Build games using the existing script
(cd "$GAMES_DIR" && sh build.sh)
