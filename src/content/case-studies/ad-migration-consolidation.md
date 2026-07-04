---
title: "Active Directory migration and domain consolidation"
summary: "Migrated a multi-domain AD forest to a single clean domain, decommissioning legacy DCs and fixing years of accumulated cruft."
tags: ["Active Directory", "Windows Server", "Migration", "PowerShell"]
when: "Recent"
kind: "client"
---

## The situation

A mid-sized organization had grown through acquisitions and ended up with multiple AD domains, stale user objects going back years, GPO conflicts nobody understood, and four domain controllers — two of which were running end-of-life OS versions. Nobody had touched the replication topology since the last sysadmin left.

## What I delivered

- Full AD audit: stale users, stale computers, orphaned groups, GPO conflict analysis
- FSMO role inventory and safe migration plan to the surviving DC
- Staged DC decommission with DNS validation at each step
- GPO cleanup: removed 40+ redundant or conflicting policies, documented the ones kept
- New OU structure matching the actual org chart
- Handoff runbook covering daily operations and the "what to do if" scenarios

## Outcome

- Single healthy domain controller running a supported OS
- AD object count reduced by 60% (stale cleanup)
- Replication clean with no errors
- IT team can now read their own Group Policy without a forensics session

> Environment details generalized. User count and domain names withheld.
