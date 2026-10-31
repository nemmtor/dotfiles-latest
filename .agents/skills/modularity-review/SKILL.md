---
name: Modularity Review
description: Review existing code for modularity and coupling imbalances using Vlad Khononov's Balanced Coupling model.
---

# Modularity Review

Run the upstream workflow from `references/upstream/`, relative to this skill's directory.

Before starting, read these files in full:
1. `skills/balanced-coupling/SKILL.md`
2. `skills/document/SKILL.md`
3. `skills/review/SKILL.md`

Resolve those paths against the upstream directory above. Follow the review workflow with these compatibility mappings:
- Dependencies described as preloaded are the files read above.
- Use the host's available tools: in OpenCode, `question` for `AskUserQuestion`, `read` for `Read`, `grep` for `Grep`, `glob` for `Glob`, and `patch` for `Write`/`Edit`; otherwise use equivalent native tools.
- If LSP is unavailable, use code searches and read the actual definitions and callers.
- For `TaskCreate`/`TaskUpdate`, use a task tool if available; otherwise maintain a concise Markdown checklist in the conversation.
- Resolve document assets, including `${CLAUDE_SKILL_DIR}/assets/template.html`, relative to the upstream `skills/document/` directory.
- Replace inline shell date placeholders in output paths with the current date in YYYY-MM-DD format.
- Resolve project inputs and generated outputs relative to the user's active project, not the upstream directory.
- Preserve the workflow's one-question-at-a-time interaction and document requirements.
