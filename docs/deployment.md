# Deployment (Cloudflare Pages)

This repo is designed to deploy on Cloudflare Pages using the **Astro** preset.

## Recommended Cloudflare Pages settings

- Framework preset: **Astro**
- Build command: `npm run build`
- Output directory: `dist`

## What happens during build

- MkDocs generates docs into `public/docs/`
- Astro builds the site into `dist/`
- Static docs end up at `dist/docs/`

## Notes

- Environment variables must be set in **Cloudflare Pages > Settings > Environment variables**.
- Changes to env vars require a new build to take effect.

