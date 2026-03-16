#!/bin/sh
set -eu

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"
PREFIX="${PREFIX:-$HOME/.local/oscar64}"

need_cmd() {
  command -v "$1" >/dev/null 2>&1 && return 0

  if command -v apt-get >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y cmake g++ make
    return 0
  fi

  if command -v dnf >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
    sudo dnf install -y cmake gcc-c++ make
    return 0
  fi

  if command -v pacman >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
    sudo pacman -Sy --needed cmake gcc make
    return 0
  fi

  if command -v zypper >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
    sudo zypper install -y cmake gcc-c++ make
    return 0
  fi

  echo "Missing required tool: $1"
  echo "Install cmake, a C++ compiler, and make, then rerun this script."
  exit 1
}

need_cmd cmake
need_cmd c++
need_cmd make

cmake -S "$ROOT_DIR" -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release
cmake --build "$BUILD_DIR" --config Release
cmake --install "$BUILD_DIR" --prefix "$PREFIX"

if [ ! -e "$BUILD_DIR/include" ]; then
  ln -s "$ROOT_DIR/include" "$BUILD_DIR/include"
fi

echo "Installed Oscar64 to $PREFIX"
echo "Add $PREFIX/bin to PATH to use oscar64 from the shell."