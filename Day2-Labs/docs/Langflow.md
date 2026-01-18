Disable all other tools in Langflow just keep the rivergate one

```
{
  "mcpServers": {
    "lf-starter_project": {
      "command": "uvx",
      "args": [
        "mcp-proxy",
        "http://localhost:7860/api/v1/mcp/project/b77e9a1d-8fa5-49b4-ad58-2fdf57c294b9/sse"
      ]
    }
  }
}
```