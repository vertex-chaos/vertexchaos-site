# Request/Flow Map

This is a static site. “Flow” is basically the build pipeline and the way routes map to files.

## Runtime (in browser)

- `/` -> `src/pages/index.astro`
- `/services` -> `src/pages/services.astro`
- `/upwork` -> `src/pages/upwork.astro`
- `/resume` -> `src/pages/resume.astro`
- `/contact` -> `src/pages/contact.astro`
- `/legal` -> `src/pages/legal.astro`
- `/privacy` -> `src/pages/privacy.astro`
- `/docs/…` -> generated MkDocs output copied into the Astro build

## Build-time

1. `npm run build`
2. `node scripts/build-docs.mjs`
3. `pip install -r docs/requirements.txt`
4. `mkdocs build -d public/docs`
5. `astro build` -> produces `dist/`

