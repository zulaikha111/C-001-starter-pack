# Git Installation Scripts

This folder contains automated installation scripts for Git and Claude Code on multiple platforms.

## Scripts Overview

### Unix/macOS/Linux
- **install-git-claude-unix.sh** - Bash script for Unix-based systems

### Windows
- **install-git-claude-windows.bat** - Batch script for Windows (legacy)
- **install-git-claude-windows.ps1** - PowerShell script for Windows (recommended)

## What These Scripts Do

Each script will:
1. Check if Git is already installed
2. Install Git if not present (using the appropriate package manager for your system)
3. Install Claude Code via npm
4. Add Claude Code to your system PATH
5. Verify the installation

## Usage Instructions

### For Unix/macOS/Linux

1. Open Terminal
2. Navigate to this directory
3. Make the script executable:
   ```bash
   chmod +x install-git-claude-unix.sh
   ```
4. Run the script:
   ```bash
   ./install-git-claude-unix.sh
   ```

**Supported Systems:**
- macOS (using Homebrew or Xcode Command Line Tools)
- Ubuntu/Debian (using apt-get)
- RedHat/CentOS (using yum)
- Fedora (using dnf)
- Arch Linux (using pacman)

### For Windows (PowerShell - Recommended)

1. Open PowerShell as Administrator (right-click PowerShell → "Run as administrator")
2. Navigate to this directory
3. Enable script execution (if needed):
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
4. Run the script:
   ```powershell
   .\install-git-claude-windows.ps1
   ```

### For Windows (Batch File)

1. Open Command Prompt as Administrator
2. Navigate to this directory
3. Run the script:
   ```batch
   install-git-claude-windows.bat
   ```

## Prerequisites

### Unix/macOS/Linux
- **macOS**: Homebrew is recommended (install from https://brew.sh)
- **Linux**: A supported package manager (apt, yum, dnf, or pacman)

### Windows
- One of the following package managers:
  - **winget** (included in Windows 10 1809+ and Windows 11) - Recommended
  - **Chocolatey** (install from https://chocolatey.org/install)
- Or be prepared to install Git and Node.js manually if prompted

## After Installation

1. **Restart your terminal/command prompt** to ensure PATH changes take effect
2. Verify Git installation:
   ```bash
   git --version
   ```
3. Verify Claude Code installation:
   ```bash
   claude --version
   ```
4. Start using Claude Code:
   ```bash
   claude
   ```

## Troubleshooting

### "Command not found" after installation
- Close and reopen your terminal/command prompt
- The PATH may need to be refreshed

### Permission errors (Unix/macOS/Linux)
- Some installations may require sudo privileges
- The script will prompt you when needed

### Permission errors (Windows)
- Run PowerShell or Command Prompt as Administrator
- Right-click the application and select "Run as administrator"

### Package manager not found
- Install the appropriate package manager for your system
- Or install Git and Node.js manually:
  - Git: https://git-scm.com/downloads
  - Node.js: https://nodejs.org/

## Manual Installation

If the scripts fail, you can install manually:

1. Install Git: https://git-scm.com/downloads
2. Install Node.js: https://nodejs.org/
3. Install Claude Code:
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

## Support

For issues with:
- **Git**: Visit https://git-scm.com/
- **Node.js**: Visit https://nodejs.org/
- **Claude Code**: Visit https://github.com/anthropics/claude-code
