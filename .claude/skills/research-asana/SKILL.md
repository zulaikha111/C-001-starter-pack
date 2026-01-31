---
name: research-asana
description: Find 2 papers with @research-finder, then create an Asana project + tasks with @project-planner.
disable-model-invocation: true
argument-hint: "\"<topic>\" \"<timeline>\""
---
You are running the /research-asana skill.

Input arguments:
- Topic is $0
- Timeline is $1

If $1 is missing, default Timeline to "1 month".

Workflow (must be followed in order):
1) Call @research-finder with exactly:
   Find 2 papers on <Topic>

2) Wait for @research-finder to finish.
   It will return two lines like:
   - Paper A: [Title] | [URL]
   - Paper B: [Title] | [URL]
   and it ends with the word COMPLETED.

3) Extract:
   - paper_a_title, paper_a_url
   - paper_b_title, paper_b_url

4) Call @project-planner and pass:
   - topic: <Topic>
   - timeline: <Timeline>
   - Paper A line (exactly as returned)
   - Paper B line (exactly as returned)

5) Final output to the user:
   Return ONLY the final Asana Project URL.
   Do not include any other text.
