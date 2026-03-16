#!/bin/sh
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"

# Install CMake if missing
if ! command -v cmake >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    brew install cmake
  else
    echo "CMake not found. Install Homebrew or CMake."
    exit 1
  fi
fi

# Configure and build
cmake -S "$ROOT_DIR" -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILD_DIR" --config Release

# Ensure compiler can find includes relative to build folder
if [ ! -e "$BUILD_DIR/include" ]; then
  ln -s "$ROOT_DIR/include" "$BUILD_DIR/include"
fi

echo "Built: $BUILD_DIR/Release/oscar64"
