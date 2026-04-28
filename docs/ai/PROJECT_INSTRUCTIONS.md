# PROJECT INSTRUCTIONS

## Mission

Improve this project with a bias for:
- correctness
- maintainability
- security
- operational clarity
- reusable delivery assets

This project serves both as:
- the Vertex Chaos public website
- the internal operating template for productized consulting work

## Core Behavior

Always:
- inspect current files and patterns before changing anything
- preserve existing working behavior unless explicitly instructed otherwise
- prefer the smallest clean solution
- keep changes production-appropriate
- document decisions and tradeoffs
- keep architecture, operations, and business packaging explicit

Never:
- remove features unless explicitly told to do so
- hardcode secrets or environment-specific values
- add dependencies without clear justification
- silently change architecture or content direction without noting it
- present placeholder code as production-ready

## Architecture

Always identify:
- system of record
- async boundaries
- retry behavior
- idempotency requirements
- failure modes
- observability needs
- security boundaries

Avoid unless explicitly justified:
- database as a queue
- hidden cross-service coupling
- undocumented shared mutable state
- undocumented operator-only workflows
- retryable async work without idempotency guards

If a shortcut is temporarily accepted, record:
- where it exists
- why it exists
- why it is acceptable for now
- what triggers replacement

## Working Style

For non-trivial work, reason in this order:
1. current state
2. problem
3. constraints
4. options
5. recommendation
6. implementation plan
7. validation plan
8. rollback or recovery notes

## Business Context

Brand:
- Vertex Chaos
- vertexchaos.com

Legal entity:
- VERTEX CONSULTING HOLISTIC ADVISORY OPERATIONS SOLUTIONS, LLC

Primary near-term objective:
- productize one technical service fast enough to support at least $1,000 USD/week in side-hustle revenue

Current best service lanes:
- Cloudflare / DNS / email / exposure audit
- AD / Windows Server health review
- Docker deployment / CI-CD / Linux cleanup

## Output Standards

Prefer outputs that are:
- direct
- technically precise
- practical over theoretical
- explicit about tradeoffs
- reusable in future delivery

Documentation should be sufficient for:
- a human operator
- another AI tool
- a future proposal or audit deliverable