#!/bin/sh
set -eu

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"
PREFIX="${PREFIX:-$HOME/.local/oscar64}"

if ! command -v cmake >/dev/null 2>&1; then
  if command -v brew >/dev/null 2>&1; then
    brew install cmake
  else
    echo "CMake not found. Install Homebrew or CMake first."
    exit 1
  fi
fi

cmake -S "$ROOT_DIR" -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILD_DIR" --config Release
cmake --install "$BUILD_DIR" --prefix "$PREFIX"

if [ ! -e "$BUILD_DIR/include" ]; then
  ln -s "$ROOT_DIR/include" "$BUILD_DIR/include"
fi

echo "Installed Oscar64 to $PREFIX"
echo "Add $PREFIX/bin to PATH to use oscar64 from the shell."