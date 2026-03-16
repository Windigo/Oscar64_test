# Oscar64 Installation Guide

This document explains how to build and install Oscar64 on macOS, Linux, and Windows using the scripts included in this repository.

## What gets installed

The install scripts place Oscar64 in a private prefix with this layout:

```text
<prefix>/bin/oscar64
<prefix>/include/oscar64/
<prefix>/share/man/man1/oscar64.1
```

This layout matters because the compiler looks for its runtime headers relative to the executable.

## Default install locations

- macOS: `$HOME/.local/oscar64`
- Linux: `$HOME/.local/oscar64`
- Windows: `%LOCALAPPDATA%\\oscar64`

You can override the install prefix with `PREFIX`.

## macOS

### Requirements

- Xcode Command Line Tools
- `cmake`
- A C++ compiler
- Optional: Homebrew, if `cmake` is not already installed

### Install

From the repository root:

```sh
chmod +x install_macos.sh
./install_macos.sh
```

To install somewhere else:

```sh
PREFIX="$HOME/tools/oscar64" ./install_macos.sh
```

### Add to PATH

For zsh:

```sh
echo 'export PATH="$HOME/.local/oscar64/bin:$PATH"' >> ~/.zshrc
. ~/.zshrc
```

### Verify

```sh
oscar64
```

You should see the command-line usage text.

## Linux

### Requirements

- `cmake`
- `make`
- `c++` or `g++`
- `sudo` if the script needs to install packages

The script tries `apt`, `dnf`, `pacman`, and `zypper` if required tools are missing.

### Install

From the repository root:

```sh
chmod +x install_linux.sh
./install_linux.sh
```

To install somewhere else:

```sh
PREFIX="$HOME/tools/oscar64" ./install_linux.sh
```

### Add to PATH

For bash:

```sh
echo 'export PATH="$HOME/.local/oscar64/bin:$PATH"' >> ~/.bashrc
. ~/.bashrc
```

For zsh:

```sh
echo 'export PATH="$HOME/.local/oscar64/bin:$PATH"' >> ~/.zshrc
. ~/.zshrc
```

### Verify

```sh
oscar64
```

## Windows

### Requirements

- CMake in `PATH`
- Visual Studio or Build Tools with C++ support
- A CMake-compatible generator available on the machine

### Install

From the repository root in `cmd.exe`:

```bat
install_windows.bat
```

To install somewhere else:

```bat
set PREFIX=C:\tools\oscar64
install_windows.bat
```

### Add to PATH

Add this directory to your user `PATH`:

```text
%LOCALAPPDATA%\oscar64\bin
```

If you used a custom prefix, add that `bin` directory instead.

### Verify

Open a new terminal and run:

```bat
oscar64
```

## Building samples after install

The sample `build.sh` scripts in this repository expect a repository-local compiler at `bin/oscar64`. If you are using an installed compiler from your `PATH`, you can either:

1. Run the compiler directly on a sample source file
2. Create a local `bin/oscar64` symlink or copy for compatibility with the existing sample scripts

Example:

```sh
cd samples/stdio
oscar64 helloworld.c
```

## Troubleshooting

### Could not locate Oscar64 includes

If Oscar64 reports that it cannot find its includes, check that your install prefix contains:

```text
<prefix>/bin/oscar64
<prefix>/include/oscar64/crt.h
```

If you move the executable out of that layout, the compiler may stop finding its runtime headers.

### macOS: cmake not found

Install Homebrew and rerun the script, or install CMake manually.

### Linux: missing packages

If automatic package installation is not available for your distro, install `cmake`, `make`, and a C++ compiler manually, then rerun `install_linux.sh`.

### Windows: build fails

Open a Developer Command Prompt for Visual Studio and run `install_windows.bat` there so the compiler toolchain and generator are available.
