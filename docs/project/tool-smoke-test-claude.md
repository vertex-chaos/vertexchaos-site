---
tool: claude (claude-sonnet-4-6 via Claude Code CLI)
date: 2026-04-27
status: pass
---

# Tool Smoke Test — Claude Code

## What this repo is for

`vertexchaos-site` is the public website for **Vertex Chaos** (legal entity: Vertex Consulting Holistic Advisory Operations Solutions, LLC). It doubles as an internal operating template for productized consulting work. The stated near-term business goal is `$1,000 USD/week` in side-hustle revenue from IT/infrastructure consulting services.

Stack: **Astro + Tailwind CSS v4**, static output, deployed from `dist/`.

---

## Where homepage content and config live

| What | File | Notes |
|------|------|-------|
| Site-wide config (headline, subhead, nav, links, email) | `src/config/site.ts` | Single source of truth for all repeated strings |
| Homepage layout and sections | `src/pages/index.astro` | Renders `site.headline`, `site.subhead`, service cards, work preview, footer |
| Homepage copy drafts | `docs/site/homepage-copy.md` | Written but not yet wired into the page |
| Brand voice and positioning rules | `docs/site/brand-notes.md` | Practical, senior, calm, explicit |
| Productized offer definition | `docs/business/offer.md` | One offer drafted: Cloudflare/DNS/email audit |
| Pricing model | `docs/business/pricing.md` | $300–$1,000 fixed-scope options |
| Services page | `src/pages/services.astro` | Currently a stub: "Coming soon." |
| Backlog | `docs/project/backlog.md` | Explicitly calls out homepage messaging, site.ts, index.astro, services page |

---

## What should be edited next for a professional Day-1 services-focused homepage

Priority order based on current state vs. the copy and offer docs:

### 1. `src/config/site.ts`
- Replace `headline` with the stronger copy from `docs/site/homepage-copy.md`:
  `"Infrastructure automation, cloud operations, and practical AI implementation for real businesses."`
- Replace `subhead` with the matching subtext from the same doc.
- Add a `services` link to the `links` block: `services: "/services"`.
- Add trust signals array (years of experience, Upwork rating, remote-friendly) for reuse across pages.

### 2. `src/pages/index.astro`
- Wire hero CTAs to `"Book a consultation"` (primary, → `/contact`) and `"See services"` (secondary, → `/services`).
- Add a **trust strip** row below the hero: 22+ years, PowerShell/Python/AD/Windows, Upwork 100% JSS, U.S.-based.
- Rename service cards to match the three lanes from `homepage-copy.md`: Infrastructure & Systems, Automation & DevOps, AI Enablement.
- Replace the "How I work" section's sparse ordered list with tighter consulting-oriented copy from the brand notes.
- Update the featured work card to link directly to the relevant `/work` slug rather than the index.

### 3. `src/pages/services.astro`
- Replace the "Coming soon." stub with the three service descriptions from `homepage-copy.md`.
- For each service block: name, one-sentence outcome, 3–5 tag pills, CTA to `/contact`.
- Add the productized audit offer from `docs/business/offer.md` as a highlighted card (name, deliverables, who-fits, CTA).

### 4. `docs/business/offer.md` (non-application, docs only)
- Fill in the remaining two productized offers (AD/Windows health review, Docker/CI-CD/Linux cleanup) so `services.astro` has full source material to draw from.

---

## Tool smoke-test result

| Check | Result |
|-------|--------|
| File read (project instructions) | pass |
| Repo structure traversal | pass |
| Multi-file parallel read | pass |
| Write to docs/project/ | pass |
| No application code modified | pass |
| No src/ files touched | pass |
