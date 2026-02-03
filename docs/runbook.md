# Operations Runbook

## Prereqs

- Node.js (LTS)
- Python 3.x (only required if you build docs locally)

## Environment variables

The site reads environment values at build time. See `.env.example`.

Common ones:

- `SITE_EMAIL`
- `SITE_EMAILTO` (mailto target)
- `SITE_COMPANY_LEGAL_NAME`

## Troubleshooting

### Docs build fails in CI

Common reasons:

- Python not available in the build image.
- pip install blocked.

Workaround:

- Set `SKIP_DOCS=1` for the build (not recommended for prod if you want docs published).

### “Docs are missing after deploy”

- Confirm the build log shows `mkdocs build` ran.
- Confirm `public/docs/index.html` exists before `astro build`.

