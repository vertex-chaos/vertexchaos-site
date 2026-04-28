---
tool: gemini
date: 2026-04-27
status: pass
---

# Tool Smoke Test - Gemini

## What this repo is for

`vertexchaos-site` is an Astro-based public website for Vertex Chaos at `vertexchaos.com`.

It also serves as the internal operating template for productized consulting work: agent instructions, architecture notes, business packaging, proposal/report prompts, and Day-1 execution planning.

The near-term business objective documented in `docs/ai/PROJECT_INSTRUCTIONS.md` is to productize one technical service fast enough to support at least `$1,000 USD/week` in side-hustle revenue.

Current best service lanes:
- Cloudflare / DNS / email / exposure audit
- AD / Windows Server health review
- Docker deployment / CI-CD / Linux cleanup

## Where homepage content and config live

| Purpose | File | Current role |
| --- | --- | --- |
| Astro site config | `astro.config.mjs` | Sets `site: "https://vertexchaos.com"`, `trailingSlash: "never"`, and Tailwind via Vite. |
| Site-wide brand/config | `src/config/site.ts` | Holds brand, domain, email, nav links, GitHub links, homepage headline, subhead, and shared URL targets. |
| Homepage implementation | `src/pages/index.astro` | Renders the live homepage sections, CTAs, service cards, quick links, work preview, and footer. |
| Shared layout | `src/layouts/BaseLayout.astro` | Provides global CSS, metadata, header, and main page container. |
| Header/navigation | `src/components/SiteHeader.astro` | Uses `site.nav`, `site.brand`, and `site.links.contact`. |
| Homepage copy source draft | `docs/site/homepage-copy.md` | Contains the stronger Day-1 services-focused hero, trust strip, service lanes, and CTA copy. |
| Brand voice notes | `docs/site/brand-notes.md` | Defines the desired voice: practical, senior, calm under operational mess, explicit, not flashy. |
| Productized offer source | `docs/business/offer.md` | Defines the first likely offer: Cloudflare / DNS / Email Exposure Audit. |
| Pricing source | `docs/business/pricing.md` | Keeps pricing simple, with fixed-scope audit or diagnostic options around `$300-$1,000`. |

## What files should be edited next for a professional Day-1 services-focused homepage

Do not start by inventing a new site structure. The repo already has the source material needed for a credible Day-1 services homepage.

Recommended edit order:

1. `docs/site/homepage-copy.md`
   - Tighten the draft into final approved copy before touching implementation.
   - Make the first service lane align with the likely primary offer: Cloudflare / DNS / email exposure audit.
   - Keep the language direct and operational, matching `docs/site/brand-notes.md`.

2. `docs/business/offer.md`
   - Finalize the Day-1 productized offer with scope, exclusions, deliverables, intake requirements, turnaround, and handoff format.
   - This should become the business source of truth for homepage and services-page claims.

3. `src/config/site.ts`
   - After copy approval, update shared homepage strings such as `headline`, `subhead`, CTA/link targets, and reusable trust/service data if added.
   - This is the main config surface for repeated homepage/nav/contact values.

4. `src/pages/index.astro`
   - Replace the current general-consulting homepage with the approved services-focused structure.
   - Add the trust strip from `docs/site/homepage-copy.md`.
   - Rename service cards around the practical offer lanes.
   - Change CTAs from generic `Email me`, `Portfolio`, and `GitHub` toward `Book a consultation` and `See services`.

5. `src/pages/services.astro`
   - Replace the current `Coming soon.` stub with service-lane detail.
   - Add the Cloudflare / DNS / Email Exposure Audit as the highlighted Day-1 productized offer.

## Current gap

The live homepage is functional but still reads as a broad personal consulting/portfolio page. The docs already point toward a sharper services-led site, but that direction has not yet been wired into `src/config/site.ts`, `src/pages/index.astro`, or `src/pages/services.astro`.

## Smoke-test result

| Check | Result |
| --- | --- |
| Read root instructions | pass |
| Read project instructions | pass |
| Inspect repo structure | pass |
| Identify homepage/config files | pass |
| Create controlled docs file | pass |
| Modify application code | not done |
| Touch `src/` files | not done |
