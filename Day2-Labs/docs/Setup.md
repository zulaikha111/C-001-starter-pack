# Setting up Claude

## Install Claude

### MacOS

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Add Claude to PATH for current terminal session:
```bash
export PATH="$HOME/.claude/bin:$PATH"
```

### Windows

```cmd
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

Add Claude to PATH for current terminal session:
```cmd
set PATH=%USERPROFILE%\.claude\bin;%PATH%
```

## Set Claude API Key Helper (MacOS users only!)

```
mkdir -p ~/.claude

echo '{
  "apiKeyHelper": "echo <REPLACE WITH API KEY>",
  "model": "haiku"
}' > ~/.claude/settings.json

```

## Set Claude API Key Helper (Windows users only!)

```
# Create directory and write settings.json
$configDir = "$HOME\.claude"; 
if (!(Test-Path $configDir)) { New-Item -ItemType Directory -Path $configDir -Force };
$settings = @'
{
  "apiKeyHelper": "echo <REPLACE_WITH_YOUR_KEY>",
  "model": "haiku"
}
'@;
$settings | Out-File -FilePath "$configDir\settings.json" -Encoding utf8;
Write-Host "✅ Setup complete. Launching Claude..." -ForegroundColor Green;
claude
```

## Launch Claude

```
claude
```

## Check status

```
/status
```
