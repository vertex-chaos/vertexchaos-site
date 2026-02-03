# Architecture Overview

## High-level components

- **Astro site**: pages + components + configs
- **Config layer**: a small TS config surface that reads env vars
- **Docs build**: MkDocs builds into `public/docs` before Astro builds

## Repo layout

- `src/pages/`  
  Route-based pages (`index.astro`, `services.astro`, `contact.astro`, etc.)
- `src/components/`  
  Shared UI components (`Header`, `Footer`)
- `src/config/`  
  Site settings and content wiring
- `src/styles/`  
  Global CSS, tokens, and theme
- `docs/` + `mkdocs.yml`  
  Local documentation source

## Configuration philosophy

- **Anything that changes often** (email, social links, company name, etc.) lives in config and/or `.env`.
- The deployed output is static, so **the env vars are compiled in at build time**.

