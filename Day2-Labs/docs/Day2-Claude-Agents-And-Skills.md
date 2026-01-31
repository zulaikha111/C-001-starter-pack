# Day 2: Building AI Agents & Skills

##

Make sure you have followed the steps in `Setup.md` file to install Claude Code, and configure the API Key

## Setting up Visual Studio

- Download this starter pack repo
- Unzip the file
- Open Visual Studio Code
- Click File --> Open Folder --> Select The inner folder in the unzipped starter pack folder
- Open a terminal --> Click Terminal in the menu --> New Terminal

## 1. Asana (MCP)

We use the Asana MCP server to manage projects and tasks.

**Command:**

```bash
claude mcp add --transport sse asana https://mcp.asana.com/sse
```

**Description:** Provides tools to create and manage Asana projects, tasks, and workflows.
**Asana Authentication:** Make sure you have a valid Asana trial account, and authenticate your MCP to it

## 3. Skills

Lets go through some of the skills, and agents - and their definitions

### project-checklist
- Path: `.claude/skills/project-checklist/SKILL.md`
- Creates a short beginner-friendly project checklist with done criteria, scope, and tasks. Saves to a file.

### research-asana
- Path: `.claude/skills/research-asana/SKILL.md`
- Finds 2 papers with @research-finder, then creates an Asana project + tasks with @project-planner.

## Agents

### research-finder
- Path: `.claude/agents/research-finder.md`
- Specialized agent that finds and evaluates academic papers using WebSearch tool.

### project-planner
- Path: `.claude/agents/project-planner.md`
- Specialized agent that creates research projects and tasks in Asana using Asana tool with proper structure and timelines.


## Verification Checklist for Students
- Lauch claude code from the VSCode terminal (type claude, press enter)
- Run `/mcp` — Ensure  `asana` have green dot.
- Run `/skills` — Ensure `project-checklist` and `research-asana` appear in the list.
- Run `/agents` — Ensure `project-planner`, and `research-finder` agents appear in the list.

## Test Prompts

Lets use these sample prompts to test some of the skills, and agents

### Test Single Skill
```
Use project-checklist skill to create a checklist for  "Website for community sports group" "2026-03-01"  
```

**Expected outcome:** Showing the invocation of a single Claude code agent that show reusable prompts, and the result is a project checklist markdown file.

### Test Single Agent
```
Use research-finder skill to find 2 academic papers on: LLM Transformers architecture
```

**Expected outcome:** Showing the invocation of a single Claude code agent that shows how an ageng runs tools, and acheives its outcome, in its own context window

### Test Multi-Agent Orchestration
```
/research-asana "Climate change impact on weather patterns" "1 month"
```

**Expected Result:**
- Showing how the research-asana skill delegates to research-finder and project-planner agnets, then return a complete project with paper details and Asana task links.
- Verify the Asana project, and tasks are created
