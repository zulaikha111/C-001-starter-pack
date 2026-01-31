---
name: project-checklist
description: Create a short beginner-friendly project checklist with done criteria, scope, and tasks. Saves to a file.
argument-hint: "\"<project_title>\" \"<deadline>\""
---
You are running /project-checklist.

Arguments:
- Title: $0
- Deadline: $1

Defaults:
- If $0 missing: "Project"
- If $1 missing: "Not provided"

Rules:
- Beginner friendly.
- Short sentences.
- No filler like “(3 bullets)”. You MUST write the bullets.
- Do not invent complex features unless implied by the title.
- Use checkboxes for tasks.

Workflow:
1) Create file:
   checklist-<YYYY-MM-DD>-<slugified-title>.md
   Use today's date in Australia/Melbourne.

2) Write the file with exactly this structure and fully filled content:

# <Title>
Deadline: <Deadline>
Created: <YYYY-MM-DD>

## Goal
Write 1 clear sentence.

## Definition of done
Write exactly 3 bullets. Each bullet must be measurable.
No placeholders.

## Must-haves
Write exactly 5 bullets.
Beginner-friendly.
No placeholders.

## Out of scope
Write exactly 5 bullets.
No placeholders.

## Task list
Write 10–14 checkboxes.
Each task must be small and concrete.
Use plain words.
Order them from start to finish.
Avoid vague tasks like “set up everything”.

3) Output:
Return ONLY the filename.
