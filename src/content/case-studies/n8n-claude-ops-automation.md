---
title: "AI-powered ops workflow with n8n and Claude"
summary: "Built an automation pipeline that routes incoming support requests, drafts responses using Claude, and updates the ticketing system — cutting average response time from 4 hours to under 15 minutes."
tags: ["n8n", "Claude API", "Python", "Automation", "AI"]
when: "Recent"
kind: "client"
---

## The situation

A service business was handling support requests manually: someone read the email, decided what type it was, drafted a reply, updated the CRM, and assigned it to the right person. This happened 30-50 times a day. It was the kind of work that takes a person 10 minutes each time but could be automated in an afternoon.

## What I delivered

**Intake pipeline (n8n):**
- Webhook listener on incoming email/form submissions
- Classifier node: routes by request type (billing, technical, onboarding, general)
- Priority scoring based on keywords and sender history

**AI response drafting (Claude API):**
- System prompt with company voice and policy guardrails
- Draft generation per request type — not a generic reply, a context-aware one
- Confidence threshold: low-confidence drafts flagged for human review before sending

**CRM integration:**
- Automatic ticket creation with classification, priority, and draft attached
- Human-in-the-loop approval step for sends over a defined threshold
- Logging of all AI-assisted actions for audit purposes

## Outcome

- Average response time: 4 hours → under 15 minutes
- 80% of routine requests fully automated (human reviews the other 20%)
- Staff freed from triage work — they focus on the requests that actually need a person
- Full audit trail of what the AI sent and when

> Stack: n8n self-hosted, Claude Haiku for classification and drafting, Python for the CRM connector. Client details withheld.
