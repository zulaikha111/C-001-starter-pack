# Setting up Claude

## Set Claude API Key Helper (MacOS users only!)

```
mkdir -p ~/.claude

echo '{
  "apiKeyHelper": "echo <REPLACE WITH API KEY>",
  "permissions": {
    "deny": [
      "WebSearch",
      "WebFetch"
    ]
  },
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
  "permissions": {
    "deny": [
      "WebSearch",
      "WebFetch"
    ]
  },
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
Status
```