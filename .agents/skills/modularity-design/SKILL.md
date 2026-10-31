---
name: Modularity Design
description: Design modular architectures from functional requirements using Vlad Khononov's Balanced Coupling model, with module contracts and test specifications.
---

# Modularity Design

Run the upstream workflow from `../modularity-review/references/upstream/`, relative to this skill's directory.

Before starting, read these files in full:
1. `skills/balanced-coupling/SKILL.md`
2. `skills/design/SKILL.md`

Resolve those paths against the upstream directory above. Follow the design workflow with these compatibility mappings:
- Dependencies described as preloaded are the files read above.
- Use the host's available tools: in OpenCode, `question` for `AskUserQuestion`, `read` for `Read`, and `patch` for `Write`/`Edit`; otherwise use equivalent native tools.
- For `TaskCreate`/`TaskUpdate`, use a task tool if available; otherwise maintain a concise Markdown checklist in the conversation.
- Treat the user's command arguments as the upstream argument input. If no requirements path was provided, ask for it as specified by the workflow.
- Replace inline shell date placeholders in output paths with the current date in YYYY-MM-DD format; use `shell` to obtain the date if needed.
- Resolve project inputs and generated outputs relative to the user's active project, not the upstream directory.
- Preserve the workflow's one-question-at-a-time interaction and explicit approval between stages.
