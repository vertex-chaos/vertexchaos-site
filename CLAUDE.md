# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md` — primary source of truth for mission, behavior, and working style

## Claude-Specific Rules

- Treat `docs/ai/PROJECT_INSTRUCTIONS.md` as the primary source of truth.
- Inspect current repository structure before making changes.
- Prefer minimal, coherent edits.
- Do not remove existing working features unless explicitly instructed.
- For architecture work, explicitly identify current state, target state, tradeoffs, failure modes, and migration steps.
- For async workflows, check queue semantics, idempotency, retries, and ownership.
- State assumptions clearly instead of pretending certainty.

## Commands

```bash
npm install        # install dependencies
npm run dev        # start dev server (http://localhost:4321)
npm run build      # production build to dist/
npm run preview    # serve the build locally
```

There are no test or lint scripts. The verify script runs structural checks:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify.ps1
```

## Architecture

**Stack:** Astro 5 (static site) + Tailwind CSS v4 (via `@tailwindcss/vite` plugin, no config file). No framework components — all `.astro` files.

**Site config** is the single source of truth for brand values, nav links, and social URLs: `src/config/site.ts`. Pages import `site` from there rather than hardcoding values.

**Content collections** (`src/content/`) use Astro's built-in content layer. Currently one collection:
- `case-studies/` — markdown files with frontmatter schema defined in `src/content/config.ts` (fields: `title`, `summary`, `tags[]`, `when?`, `repo?`, `kind: client|lab|open-source`)

**Layout chain:** Every page uses `BaseLayout.astro` → imports `global.css` + `SiteHeader.astro`. The `noHeader` prop suppresses the nav. Main content is constrained to `max-w-6xl` with `px-6 py-10`.

**Routing:** All static routes live in `src/pages/`. The `/work/[slug]` dynamic route is generated from the `case-studies` collection via `getStaticPaths`.

**Tailwind:** CSS is imported as `@import "tailwindcss"` in `global.css`. There is no `tailwind.config.*` — v4 uses the Vite plugin directly. Use `@layer base` / `@apply` in `global.css` for base overrides.

**`trailingSlash: 'never'`** is set in `astro.config.mjs`. Links to internal pages must not include trailing slashes.

## Adding Content

To add a case study, create `src/content/case-studies/<slug>.md` with valid frontmatter matching the schema in `src/content/config.ts`. The `/work` index and `/work/[slug]` pages pick it up automatically.

## Docs / Business Files

`docs/` contains architecture notes, business packaging, and project planning files. These are human- and agent-readable assets, not served by the site. When the user approves copy changes, apply them to `src/config/site.ts` and `src/pages/index.astro`.

## Deployment

The site deploys as a static build to `vertexchaos.com`. No server-side runtime. Keep all pages statically renderable (no `server` or `hybrid` output mode).
