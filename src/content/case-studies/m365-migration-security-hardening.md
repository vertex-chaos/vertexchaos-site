---
title: "M365 tenant migration and security hardening"
summary: "Migrated a small business from a legacy Exchange environment to M365, then hardened the tenant against the most common attack vectors."
tags: ["M365", "Exchange Online", "Entra ID", "Security", "Migration"]
when: "Recent"
kind: "client"
---

## The situation

A 40-person professional services firm was running an aging Exchange Server on-premises. The hardware was approaching end-of-life, the SSL cert had lapsed twice, and nobody knew what the MX records pointed to anymore. They wanted to move to M365 but had no one to own the project end-to-end.

## What I delivered

**Migration:**
- Pre-migration audit of mailboxes, distribution lists, shared mailboxes, and calendar permissions
- DNS cutover plan with rollback steps at each phase
- Hybrid coexistence during the 2-week migration window (zero mail loss)
- Post-migration validation: mail flow, calendar sharing, mobile device sync

**Security hardening:**
- Conditional access policies blocking legacy authentication protocols
- MFA enforced on all accounts (phased rollout over 3 days to avoid lockouts)
- Defender for Business baseline applied to all endpoints
- Secure Score from 34 → 71 in the first 30 days
- SPF, DKIM, DMARC configured correctly — all three, not just SPF

**Handoff:**
- Runbook covering license management, offboarding procedures, and the Conditional Access logic
- 30-day monitoring period with a weekly summary

## Outcome

- Zero mail lost during migration
- All 40 users on MFA within 72 hours
- Secure Score doubled in 30 days
- IT admin can manage the environment without calling a consultant for routine tasks

> Client details withheld. User count approximate.
