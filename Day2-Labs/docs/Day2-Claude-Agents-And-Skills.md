# Day 2: Building AI Agents & Skills

## 1. Google Search (MCP)

We use SerpApi to give Claude real-time access to Google Search. We use the **Hosted** version to avoid local installation issues.

**Command:**

```bash
claude mcp add google-search --scope user --transport http https://mcp.serpapi.com/<REPLACE_WITH_API_KEY>/mcp
```

**Description:** Provides real-time web search capabilities to find academic papers, research articles, and general information.

## 2. Asana (MCP)

We use the Asana MCP server to manage projects and tasks.

**Command:**

```bash
claude mcp add --transport sse asana https://mcp.asana.com/sse
```

**Description:** Provides tools to create and manage Asana projects, tasks, and workflows.

## 3. Skills

### Paper Research Skill

Searches for academic papers and formats results consistently.

**File Path:** `.claude/skills/paper-research/SKILL.md`

**Content:**

```markdown
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
```

### Smart Task Creator Skill

Creates well-structured Asana tasks with acceptance criteria.

**File Path:** `.claude/skills/smart-task-creator/SKILL.md`

**Content:**

```markdown
---
name: smart-task-creator
description: Create well-structured Asana tasks with proper descriptions and acceptance criteria.
---

# Smart Task Creator Skill

## Instructions

1. Ask user: title, due date, priority, project name (if missing)
2. Create task in Asana with:
   - Objective (1 sentence)
   - 3 acceptance criteria
   - Estimated effort
3. Return: task URL only

Keep descriptions under 200 words.
```

## 4. Agents

### Literature Review Assistant (Single Agent)

Handles complete literature review setup autonomously.

**File Path:** `.claude/agents/literature-review-assistant.md`

**Content:**

```markdown
---
name: literature-review-assistant
description: Helps researchers set up new research projects by finding papers and creating structured Asana tasks.
---

# Literature Review Assistant

## Workflow

Given a research topic:

1. Find 2 papers using google-search (num=2)
2. Create Asana project: "[Topic] Literature Review"
3. Create 3 tasks: read paper 1, read paper 2, write synthesis
4. Return: paper titles + task URLs

Keep all outputs concise.
```

### Research Finder (Subagent)

Specialized agent for finding academic papers.

**File Path:** `.claude/agents/research-finder.md`

**Content:**

```markdown
---
name: research-finder
description: Specialized agent that finds and evaluates academic papers using google-search MCP.
---

# Research Finder

## Task

Find 2 papers on given topic using google-search (num=2).

## Output

```
Paper 1: [Title]
Authors: [Names]
Year: [Year]
URL: [Link]

Paper 2: [Title]
Authors: [Names]
Year: [Year]
URL: [Link]
```

No additional text.
```

### Project Planner (Subagent)

Specialized agent for creating Asana projects and tasks.

**File Path:** `.claude/agents/project-planner.md`

**Content:**

```markdown
---
name: project-planner
description: Specialized agent that creates research projects and tasks in Asana with proper structure and timelines.
---

# Project Planner

## Task

Create Asana project with tasks for given papers and timeline.

## Steps

1. Create project: "[Topic] Research"
2. Create tasks: "Read: [Paper Title]" for each paper
3. Add synthesis task
4. Set due dates based on timeline

## Output

Return project URL + task URLs only.
```

### Research Coordinator (Orchestrator)

Main agent that coordinates the subagents.

**File Path:** `.claude/agents/research-coordinator.md`

**Content:**

```markdown
---
name: research-coordinator
description: Main orchestrator that coordinates research-finder and project-planner agents to set up complete research projects.
---

# Research Coordinator

## Workflow

1. Ask user: topic, timeline (default: 1 month)
2. Delegate to @research-finder: find 2 papers
3. Delegate to @project-planner: create project with those papers
4. Return: paper list + project URL

Keep all responses concise.
```

## Verification Checklist for Students

- Run `/mcp` — Ensure `google-search` and `asana` have green dots.
- Run `/skills` — Ensure `paper-research` and `smart-task-creator` appear in the list.
- Run `/agents` — Ensure all 4 agents appear in the list.

## Test Prompts

### Test Single Skill
```
Use paper-research skill to find papers on "few-shot learning"
```

### Test Single Agent
```
Use literature-review-assistant agent to set up a project on "prompt engineering"
```

### Test Multi-Agent Orchestration
```
Use research-coordinator agent to set up a 1-month research project on "vision transformers"
```

**Expected Result:** The coordinator should delegate to research-finder and project-planner, then return a complete project with paper details and Asana task links.
