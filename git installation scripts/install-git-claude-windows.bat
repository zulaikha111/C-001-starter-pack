@echo off
REM Installation script for Git and Claude Code on Windows
REM This script installs git if not already installed, then installs Claude Code and adds it to PATH

echo ========================================
echo Git and Claude Code Installation Script
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Warning: This script may need administrator privileges for some installations.
    echo Please run as administrator if you encounter permission errors.
    echo.
    pause
)

REM Check if git is installed
where git >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Git is already installed
    git --version
) else (
    echo Git is not installed. Installing git...
    echo.

    REM Check if winget is available (Windows 10 1809+ and Windows 11)
    where winget >nul 2>&1
    if %errorLevel% equ 0 (
        echo Installing Git using winget...
        winget install -e --id Git.Git
    ) else (
        REM Check if chocolatey is available
        where choco >nul 2>&1
        if %errorLevel% equ 0 (
            echo Installing Git using Chocolatey...
            choco install git -y
        ) else (
            echo.
            echo ========================================
            echo ERROR: No package manager found!
            echo ========================================
            echo Please install Git manually from:
            echo https://git-scm.com/download/win
            echo.
            echo Or install a package manager first:
            echo - winget (comes with Windows 10/11)
            echo - Chocolatey: https://chocolatey.org/install
            echo.
            pause
            exit /b 1
        )
    )

    echo [OK] Git installed successfully
)

echo.
echo Installing Claude Code...

REM Check if npm is installed
where npm >nul 2>&1
if %errorLevel% equ 0 (
    echo Installing Claude Code via npm...
    call npm install -g @anthropic-ai/claude-code
) else (
    echo npm not found. Installing Node.js first...

    REM Try to install Node.js using available package manager
    where winget >nul 2>&1
    if %errorLevel% equ 0 (
        echo Installing Node.js using winget...
        winget install -e --id OpenJS.NodeJS.LTS
    ) else (
        where choco >nul 2>&1
        if %errorLevel% equ 0 (
            echo Installing Node.js using Chocolatey...
            choco install nodejs-lts -y
        ) else (
            echo.
            echo ========================================
            echo ERROR: Please install Node.js manually
            echo ========================================
            echo Download from: https://nodejs.org/
            echo Then run this script again.
            echo.
            pause
            exit /b 1
        )
    )

    REM Refresh environment variables
    echo Refreshing environment variables...
    call refreshenv 2>nul || echo Please restart your terminal after this completes

    REM Try installing Claude Code again
    call npm install -g @anthropic-ai/claude-code
)

echo.

REM Verify Claude Code installation
where claude >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Claude Code installed successfully
    claude --version
) else (
    echo.
    echo [WARNING] Claude Code installation completed but 'claude' command not found in PATH
    echo Please restart your terminal/command prompt and try: claude --version
)

echo.
echo ========================================
echo Installation Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Restart your command prompt/terminal
echo 2. Verify installation: claude --version
echo 3. Run Claude Code: claude
echo.
pause
