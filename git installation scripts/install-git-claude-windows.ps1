# Installation script for Git and Claude Code on Windows (PowerShell)
# This script installs git if not already installed, then installs Claude Code and adds it to PATH

# Requires PowerShell 5.1 or later

#Requires -Version 5.1

Write-Host "========================================"  -ForegroundColor Cyan
Write-Host "Git and Claude Code Installation Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Warning: Not running as administrator. Some installations may require elevated privileges." -ForegroundColor Yellow
    Write-Host "If you encounter errors, try running PowerShell as Administrator." -ForegroundColor Yellow
    Write-Host ""
}

# Function to check if a command exists
function Test-CommandExists {
    param($command)
    $null = Get-Command $command -ErrorAction SilentlyContinue
    return $?
}

# Check if git is installed
if (Test-CommandExists git) {
    Write-Host "[OK] Git is already installed" -ForegroundColor Green
    $gitVersion = git --version
    Write-Host "    $gitVersion" -ForegroundColor Gray
} else {
    Write-Host "Git is not installed. Installing git..." -ForegroundColor Yellow
    Write-Host ""

    # Try winget first (Windows 10 1809+ and Windows 11)
    if (Test-CommandExists winget) {
        Write-Host "Installing Git using winget..." -ForegroundColor Cyan
        try {
            winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements
            Write-Host "[OK] Git installed successfully" -ForegroundColor Green

            # Refresh environment variables
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } catch {
            Write-Host "[ERROR] Failed to install Git using winget: $_" -ForegroundColor Red
            exit 1
        }
    }
    # Try chocolatey as fallback
    elseif (Test-CommandExists choco) {
        Write-Host "Installing Git using Chocolatey..." -ForegroundColor Cyan
        try {
            choco install git -y
            Write-Host "[OK] Git installed successfully" -ForegroundColor Green

            # Refresh environment variables
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
        } catch {
            Write-Host "[ERROR] Failed to install Git using Chocolatey: $_" -ForegroundColor Red
            exit 1
        }
    }
    else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "ERROR: No package manager found!" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please install Git manually from: https://git-scm.com/download/win"
        Write-Host ""
        Write-Host "Or install a package manager first:"
        Write-Host "  - winget (comes with Windows 10/11)"
        Write-Host "  - Chocolatey: https://chocolatey.org/install"
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host ""
Write-Host "Installing Claude Code..." -ForegroundColor Cyan

# Check if npm is installed
if (Test-CommandExists npm) {
    Write-Host "Installing Claude Code via npm..." -ForegroundColor Cyan
    try {
        npm install -g @anthropic-ai/claude-code
        Write-Host "[OK] Claude Code installation completed" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to install Claude Code: $_" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "npm not found. Installing Node.js first..." -ForegroundColor Yellow
    Write-Host ""

    # Try to install Node.js using available package manager
    if (Test-CommandExists winget) {
        Write-Host "Installing Node.js using winget..." -ForegroundColor Cyan
        try {
            winget install -e --id OpenJS.NodeJS.LTS --accept-package-agreements --accept-source-agreements

            # Refresh environment variables
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

            Write-Host "[OK] Node.js installed successfully" -ForegroundColor Green
        } catch {
            Write-Host "[ERROR] Failed to install Node.js: $_" -ForegroundColor Red
            exit 1
        }
    }
    elseif (Test-CommandExists choco) {
        Write-Host "Installing Node.js using Chocolatey..." -ForegroundColor Cyan
        try {
            choco install nodejs-lts -y

            # Refresh environment variables
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

            Write-Host "[OK] Node.js installed successfully" -ForegroundColor Green
        } catch {
            Write-Host "[ERROR] Failed to install Node.js: $_" -ForegroundColor Red
            exit 1
        }
    }
    else {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "ERROR: Please install Node.js manually" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "Download from: https://nodejs.org/"
        Write-Host "Then run this script again."
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Try installing Claude Code again
    Write-Host ""
    Write-Host "Installing Claude Code via npm..." -ForegroundColor Cyan
    try {
        npm install -g @anthropic-ai/claude-code
        Write-Host "[OK] Claude Code installation completed" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to install Claude Code: $_" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Refresh PATH one more time
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Verify Claude Code installation
if (Test-CommandExists claude) {
    Write-Host "[OK] Claude Code installed successfully" -ForegroundColor Green
    $claudeVersion = claude --version
    Write-Host "    Claude Code version: $claudeVersion" -ForegroundColor Gray
} else {
    Write-Host ""
    Write-Host "[WARNING] Claude Code installation completed but 'claude' command not found in PATH" -ForegroundColor Yellow
    Write-Host "Please restart your PowerShell/terminal and try: claude --version" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Restart your PowerShell/terminal"
Write-Host "2. Verify installation: claude --version"
Write-Host "3. Run Claude Code: claude"
Write-Host ""
Read-Host "Press Enter to exit"
