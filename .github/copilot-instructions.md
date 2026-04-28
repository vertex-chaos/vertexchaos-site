# Copilot Repository Instructions

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Repository Rules

- Make the smallest clean change that solves the problem.
- Follow the repository's existing structure and conventions.
- Do not remove features unless explicitly instructed.
- Keep secrets and environment-specific values out of source files.
- Keep code, docs, and operations explicit.

## Architecture Rules

When changing architecture-related code or docs:
- identify the system of record
- identify async boundaries
- identify retry and idempotency requirements
- call out risky patterns, including database-as-a-queue

## Documentation Rules

When changing behavior, update relevant docs if present:
- architecture docs
- runbooks
- config examples
- operational notes