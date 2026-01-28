---
name: paper-research
description: Search for academic papers on a given topic and provide structured summaries.
---

# Paper Research Skill

## Instructions

1. Use google-search MCP with `num=2` parameter to find exactly 2 papers
2. Extract: title, authors, year, key finding (1 sentence max), URL
3. Format as:

```
Paper: [Title]
Authors: [Names]
Year: [Year]
Key Findings: [One sentence]
URL: [Link]
────────────────────────────────────────
Paper: [Title]
Authors: [Names]
Year: [Year]
Key Findings: [One sentence]
URL: [Link]
```

Return only this format, no extra text.
