---
title: "SkillRadar — freelance skill gap analysis engine"
summary: "Built a Django + PostgreSQL system that ingests job postings, scores skill gaps using a composite demand/adjacency/speed formula, and delivers weekly Telegram digests."
tags: ["Django", "Python", "PostgreSQL", "Claude API", "n8n", "AI"]
when: "2026"
kind: "lab"
---

## The problem

Running a freelance consulting business means constantly deciding: what should I apply to, and what should I learn next? The answers change weekly as market demand shifts. Doing this manually — reading job postings, comparing to your skill set, estimating learning time — is slow and inconsistent.

## What I built

**Data pipeline:**
- Upwork job search results ingested into PostgreSQL via Django management commands
- Skill extraction from job tags + NLP regex pass on descriptions
- 65-skill profile seed covering infra, M365, Python, AI/LLM, networking, security, automation

**Gap scoring engine:**
- Composite score: `demand × adjacency × speed-to-billable`
- Demand: frequency of skill in 7-day job window, normalized
- Adjacency: bucket-match against profile categories; Claude Haiku for unknown skills
- Speed: static map (FastAPI = 3 days, Kubernetes = 60 days) with Claude fallback
- Verdicts: `exploit_now` (≥0.6), `learn` (0.25–0.6), `ignore` (<0.25)

**Weekly digest:**
- Telegram bot message every Monday 8am
- Top 3 exploit-now skills, top 3 to learn, focus category
- Powered by Claude Haiku (~$0.001/unknown skill, 30-day cache)

**Proposal tracking:**
- Django + Django Ninja REST API
- Upwork MCP auto-logs every submitted proposal
- Stale proposal alerts (>48h no response) via Telegram
- Admin UI at `/admin/`

## Stack

Django 6 · Django Ninja · PostgreSQL · n8n · Claude Haiku · Telegram Bot API · Upwork browser automation (Patchright/CDP)

## What I learned

- Vue-controlled sr-only checkboxes need CDP label clicks, not JS event dispatch
- Cloudflare rate limits at 3-4 rapid navigations — 30s inter-request throttle is the safe zone
- GraphQL response interception is more reliable than DOM scraping for balance data

[Source code](https://github.com/vertex-chaos/jobhunt) — private repo, available on request.
