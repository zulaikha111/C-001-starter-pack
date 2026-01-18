# Day 2: Building AI Agents & Skills

## 1. The Search Tool (MCP)

We use SerpApi to give Claude real-time access to Google Search. We use the **Hosted** version to avoid local installation issues.

**Command:**

```bash
claude mcp add google-search --scope user --transport http https://www.google.com/search?q=https://mcp.serpapi.com/YOUR_API_KEY/mcp
```

**Description:** Provides real-time web search capabilities to find local businesses, coordinates, and points of interest.

## 2. The Weather Tool (MCP)

We use the Open-Meteo server. It is global, supports Australia (BOM data), and requires no credit cards or keys.

**Command:**

```bash
claude mcp add weather --scope user -- npx -y @dangahagan/weather-mcp
```

**Description:** Retrieves high-accuracy weather forecasts, current conditions, and location geocoding for any Australian town.

## 3. The Specialist Agent

We create a **Subagent** to handle the weather research. This keeps the main chat window clean and saves tokens.

**File Path:** `.claude/agents/weather-analyst.md`

**Content:**

```markdown
---
name: weather-analyst
description: Automatically handles all Australian weather research, location searching, and road condition analysis.
tools: [weather]
---

# PRE-FLIGHT CHECK (Mandatory)
Before using ANY tool:
1. Identify the requested location.
2. If the location is NOT in Victoria or Sydney (e.g., Perth, Adelaide, Brisbane):
   - **DO NOT CALL THE WEATHER TOOL.**
   - Immediately respond: "I am geofenced to the Melbourne-Sydney corridor. I cannot retrieve data for [Location]."
   - Stop processing.

# Instructions

You are a Weather Specialist for Australian Road Trips.

1. Use `search_locations` to find the exact Lat/Long for any town mentioned.
2. Retrieve the 3-day forecast.
3. If wind gusts exceed 40km/h or the UV index is above 8, provide a specific safety warning.
4. Greet the user by name if it is provided in your instructions.
```



## 4. The Presentation Skill

This **Skill** ensures that no matter how messy the raw data is, the output for the user is beautiful and easy to read.

**File Path:** `.claude/skills/weather-style/SKILL.md`

**Content:**

```markdown
---
name: weather-style
description: Automatically formats raw meteorological data into emoji-rich tables for travel reports.
---

# Formatting Rules

1. Start with a header: `# 🇦🇺 Weather Report: [Location]`
2. Use a Markdown table for Current Temp, Humidity, and Wind.
3. Use specific emojis for conditions: ☀️ (Sunny), 🌦️ (Showers), ⛈️ (Storms).
4. Always end with: "Drive Safe! 🚗", and a funny travel joke
```
## Final `CLAUDE.md` Configuration

This file acts as the Orchestrator. It ensures the main Claude instance knows exactly when to use the tools you just built. Copy this into the root of your project folder.

```markdown
# Project: Australian Road Trip Planner
Location: Melbourne, VIC

## Available Subagents
- **@weather-analyst**: Delegate all weather research, location lookups, and forecast analysis to this agent.

## Available Skills
- **weather-style**: This skill is automatically active. It must be used to format any weather data into user-facing tables.

## Project Rules
- All temperatures must be in Celsius.
- All distances must be in Kilometers.
- Prefer local Australian Bureau of Meteorology (BOM) data interpretations via Open-Meteo.
```

## Verification Checklist for Students

- Run `/mcp` — Ensure `google-search` and `weather` have green dots.
- Run `/agents` — Ensure `weather-analyst` appears in the list.

**The Master Test:** Type:

> Check the weather for my drive from Melbourne to Albury tomorrow.

**Expected Result:** Claude should automatically spawn the analyst, find the data, and present a table with emojis without you asking for them.
