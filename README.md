# Vertex Chaos site (Astro + Tailwind v4)

Dark/neutral theme with a calm green accent, built to be easy to update.

## Pages
- `/` Home
- `/services` Services + deliverables
- `/work` Public-safe case studies
- `/resume` Scrollable resume + embedded PDF
- `/upwork` Upwork materials (public-safe)
- `/contact` Contact for quote (mailto)
- `/legal` Legal + privacy (mockup)
- `/privacy` Alias to `/legal`

## Configuration
All public-facing config is read from environment variables in `.env` (see `.env.example`).

## Local dev
```bash
npm install
npm run dev
```

## Tailwind v4 note
Tailwind is wired using the official Vite plugin and CSS-first setup (`@import "tailwindcss";`).

## Local docs (/docs)

This repo includes a repo-contained MkDocs site that auto-builds into `/docs`.

### Build docs locally

```bash
# site + docs
npm run build

# site only
SKIP_DOCS=1 npm run build
```

Docs output is generated into `public/docs/` and gets published as `dist/docs/`.
