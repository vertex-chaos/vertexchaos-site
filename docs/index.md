# VertexChaos Local Code Wiki

This repo is the **Astro** codebase that deploys **vertexchaos.com** on **Cloudflare Pages**.

## What this gives you

- A self-contained documentation site generated at build time.
- Published under **/docs** on the same domain.
- No external hosting dependencies for docs.

## Where it lives

- Source docs: `docs/`
- MkDocs config: `mkdocs.yml`
- Built output: `public/docs/` (copied into `dist/docs/` by Astro)

## Quick commands

### Local dev (site)

```bash
npm i
npm run dev
```

### Build (site + docs)

```bash
npm run build
```

### Build (site only)

```bash
SKIP_DOCS=1 npm run build
```

