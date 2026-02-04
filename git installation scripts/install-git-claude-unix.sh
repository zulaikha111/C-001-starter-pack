#!/bin/bash

# Installation script for Git and Claude Code on Unix/macOS
# This script installs git if not already installed, then installs Claude Code and adds it to PATH

set -e

echo "========================================"
echo "Git and Claude Code Installation Script"
echo "========================================"
echo ""

# Check if git is installed
if command -v git &> /dev/null; then
    echo "✓ Git is already installed (version $(git --version))"
else
    echo "Git is not installed. Installing git..."

    # Detect OS and install git accordingly
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            echo "Detected Debian/Ubuntu system"
            sudo apt-get update
            sudo apt-get install -y git
        elif command -v yum &> /dev/null; then
            echo "Detected RedHat/CentOS system"
            sudo yum install -y git
        elif command -v dnf &> /dev/null; then
            echo "Detected Fedora system"
            sudo dnf install -y git
        elif command -v pacman &> /dev/null; then
            echo "Detected Arch Linux system"
            sudo pacman -S --noconfirm git
        else
            echo "❌ Error: Could not detect package manager. Please install git manually."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "Detected macOS"
        if command -v brew &> /dev/null; then
            echo "Installing git using Homebrew..."
            brew install git
        else
            echo "Homebrew not found. Installing Xcode Command Line Tools (includes git)..."
            xcode-select --install
            echo "Please complete the Xcode Command Line Tools installation and run this script again."
            exit 1
        fi
    else
        echo "❌ Error: Unsupported operating system: $OSTYPE"
        exit 1
    fi

    echo "✓ Git installed successfully"
fi

echo ""
echo "Installing Claude Code..."

# Install Claude Code using npm (recommended method)
if command -v npm &> /dev/null; then
    echo "Installing Claude Code via npm..."
    npm install -g @anthropic-ai/claude-code
else
    echo "npm not found. Attempting to install Node.js first..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Install Node.js on Linux
        if command -v apt-get &> /dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command -v yum &> /dev/null || command -v dnf &> /dev/null; then
            curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
            sudo yum install -y nodejs || sudo dnf install -y nodejs
        else
            echo "❌ Error: Please install Node.js and npm manually from https://nodejs.org/"
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Install Node.js on macOS
        if command -v brew &> /dev/null; then
            brew install node
        else
            echo "❌ Error: Please install Homebrew first or install Node.js manually from https://nodejs.org/"
            exit 1
        fi
    fi

    # Try installing Claude Code again
    npm install -g @anthropic-ai/claude-code
fi

# Verify Claude Code installation
if command -v claude &> /dev/null; then
    echo "✓ Claude Code installed successfully"
    echo "✓ Claude Code version: $(claude --version)"
else
    echo "⚠ Warning: Claude Code installation completed but 'claude' command not found in PATH"
    echo "You may need to restart your terminal or add the npm global bin directory to your PATH"

    # Provide helpful information about PATH
    NPM_BIN=$(npm bin -g 2>/dev/null || echo "")
    if [ -n "$NPM_BIN" ]; then
        echo ""
        echo "Add this to your ~/.bashrc or ~/.zshrc file:"
        echo "export PATH=\"$NPM_BIN:\$PATH\""
    fi
fi

echo ""
echo "========================================"
echo "Installation Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc (or ~/.zshrc)"
echo "2. Verify installation: claude --version"
echo "3. Run Claude Code: claude"
echo ""
