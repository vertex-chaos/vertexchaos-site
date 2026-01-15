---
title: "Secure SFTP ingestion automation"
summary: "Automated retrieval and verification of file drops over SFTP, with predictable logging and safe retries."
tags: ["PowerShell", "SFTP", "Automation", "Windows"]
when: "Recent"
repo: "sftp-ingestion-sample"
kind: "client"
---

## The situation
A recurring workflow depended on manual SFTP pulls and ad-hoc checking. Errors were easy to miss and rework was common.

## What I delivered
- Automated SFTP downloads with deterministic folder structure
- Checksums / file validation and safe retry logic
- Structured logs suitable for “what happened?” questions
- Idempotent design so reruns do not create duplicates

## Outcome
- Faster turnaround with fewer manual steps
- Lower failure rate through validation and retries
- Clear audit trail for operations

> Details are generalized to protect the client environment.
