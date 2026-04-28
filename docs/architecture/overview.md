# Architecture Overview

## Current System

This repository currently contains:
- an Astro static site for vertexchaos.com
- source implementation under `src/`
- deployment target of Cloudflare Pages
- repo-level configuration in `.github/`

## Current Purpose

The repo now also serves as:
- the source of truth for website messaging
- the AI instruction layer for Claude, Copilot, Codex-style agents, and Gemini
- the working archive for offers, prompts, architecture notes, and delivery process

## System of Record

- Website implementation: this repository
- Business positioning and offer drafts: `docs/business/`
- Architecture guidance: `docs/architecture/`
- Agent operating guidance: `docs/ai/PROJECT_INSTRUCTIONS.md`

## Next Planned Execution Layer

After content approval:
- update `src/config/site.ts`
- update `src/pages/index.astro`
- optionally add or tighten `/services`, `/about`, and `/contact`