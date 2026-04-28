# AGENTS.md

This file governs the entire repository.

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Agent Rules

- Inspect code and docs before editing.
- Preserve working behavior unless explicitly told otherwise.
- Prefer minimal, production-sensible changes.
- Do not invent missing requirements.
- Do not hardcode secrets, credentials, or environment-specific endpoints.
- Do not silently introduce architecture changes without documenting them.

## Required Checks

For non-trivial changes, verify:
- data ownership
- failure behavior
- retry behavior
- idempotency where relevant
- configuration impact
- deployment and operations impact