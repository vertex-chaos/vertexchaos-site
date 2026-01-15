# vertexchaos.com (site)

Static site (Astro) intended for Cloudflare Pages.

## What this is
A clean, fast marketing + portfolio site:
- services
- anonymized case studies
- curated repos list
- email-first contact

## Local dev
```bash
npm i
npm run dev
```

## Build
```bash
npm run build
npm run preview
```

## Deploy (Cloudflare Pages)
- Framework preset: Astro
- Build command: `npm run build`
- Output directory: `dist`

## Customize
- Brand/email/social: `src/config/site.ts`
- Repo list: `src/pages/repos.astro`
- Case studies: `src/content/case-studies/*.md`
