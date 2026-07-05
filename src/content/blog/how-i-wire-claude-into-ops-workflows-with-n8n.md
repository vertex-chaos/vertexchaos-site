---
title: "How I wire Claude into ops workflows with n8n"
date: "2026-07-01"
summary: "A practical pattern for connecting Claude to real infrastructure events using n8n — no code, no servers, and no prompt engineering degree required."
tags: ["AI", "n8n", "Claude", "automation", "ops"]
draft: false
---

Most "AI in IT" content is either toy demos or enterprise platform sales. This is neither. It's the actual pattern I use to connect Claude to real ops workflows — alerts, tickets, Slack messages, runbooks — using n8n as the glue layer.

The goal isn't to replace ops engineers. It's to stop wasting their time on the first 20 minutes of every incident.

## The pattern

Every workflow follows the same structure:

```
Trigger → Collect context → Claude → Route to action
```

The trigger is whatever event you want to handle: a Grafana alert, a new Zendesk ticket, a scheduled job that scans something. The context collection step gathers everything Claude needs to reason about it. Claude produces structured output. The routing step acts on it.

That's it. The power is in what you put in each box.

## A real example: alert triage

The problem: our monitoring generates 40-60 alerts per day. Maybe 5 of them need immediate human attention. The rest are noise, known issues, or things that resolve themselves. Oncall engineers were spending the first hour of every shift manually sorting through them.

The n8n workflow:

**Trigger:** Webhook from alerting system (Grafana, PagerDuty, or direct from the monitoring tool via HTTP node)

**Context collection:**
- Alert name, severity, affected host/service
- Last 10 similar alerts for that service (HTTP request to monitoring API)
- Current runbook for that alert type (HTTP request to Confluence or Notion)
- Time of day, whether it's a change window

**Claude node:**
```
You are an ops triage assistant. Given this alert and context, classify it:
- CRITICAL: needs immediate human response, wake oncall
- HIGH: needs response within 30 minutes, send to Slack
- MEDIUM: ticket it, no page
- LOW: log and close

Respond in JSON: { "severity": "...", "reasoning": "...", "suggested_action": "..." }

Alert: {{ $json.alert_name }}
Severity from monitoring: {{ $json.severity }}
Recent similar alerts (last 24h): {{ $json.similar_count }}
Runbook: {{ $json.runbook_excerpt }}
```

**Routing:**
- CRITICAL → PagerDuty trigger + Slack message with Claude's reasoning
- HIGH → Slack message to oncall channel
- MEDIUM → Jira ticket with Claude's summary + runbook link
- LOW → log to database, close alert

The key thing: Claude's *reasoning* goes into every output. The oncall engineer doesn't just get "HIGH priority" — they get "Disk usage on db-prod-1 is at 87% and has increased 12% in the last 6 hours. At current rate it will hit 95% in approximately 4 hours. Last similar alert resolved by running archive job. Runbook: [link]."

That's the 20 minutes of context gathering they don't have to do manually anymore.

## Structured output is not optional

If you prompt Claude to "summarize this alert," you get prose. Prose can't be routed. You need JSON.

Two ways to get it reliably:

**1. Tell Claude the schema explicitly:**
```
Respond only with valid JSON matching this schema exactly:
{ "severity": "CRITICAL|HIGH|MEDIUM|LOW", "reasoning": "string", "action": "string" }
Do not include markdown, code fences, or explanation.
```

**2. Use Claude's tool use / function calling:**
Define a `classify_alert` tool with the schema. Claude will always call it with valid structured output. n8n can trigger Claude via its HTTP node hitting the Anthropic API directly with `tools` defined in the body.

I use option 2 for anything that needs to be reliable in production. Option 1 works fine for low-stakes workflows where occasional JSON parse failures are acceptable.

## The context window is your friend

One thing that surprises people: you can give Claude a lot of context and it uses it well. I regularly pass:
- The full alert body (sometimes several KB of JSON)
- The last 30 lines of relevant logs
- The current runbook (often 500-1000 words)
- A summary of recent similar incidents

Total input: 3,000-5,000 tokens. With Claude Haiku at $0.25/M input tokens, that's a fraction of a cent per triage. The whole workflow costs less than a dollar a day for a team generating 60 alerts.

## What this is not good for

**Anything that requires real-time decision-making.** The round-trip to Claude adds 1-3 seconds. For alert triage, that's fine. For a circuit breaker that needs to fire in milliseconds, it's not.

**Anything where the cost of a wrong answer is catastrophic.** Claude classifying an alert as MEDIUM when it's actually CRITICAL is a problem. The mitigation: always have a human-review step for MEDIUM→HIGH borderline cases, and tune the prompt to be conservative (bias toward escalation when uncertain).

**Replacing runbooks.** The workflow surfaces the runbook, it doesn't replace it. Claude tells the engineer which runbook applies and what the relevant section is. The engineer still executes it.

## The n8n-specific setup

The HTTP Request node hitting the Anthropic API directly is the most flexible approach. The body:

```json
{
  "model": "claude-haiku-4-5-20251001",
  "max_tokens": 512,
  "tools": [{ "name": "classify_alert", "description": "...", "input_schema": {...} }],
  "messages": [{ "role": "user", "content": "{{ $json.prompt }}" }]
}
```

Set the `x-api-key` header to your Anthropic API key (stored as an n8n credential). Parse `tool_use` from the response with a Code node:

```javascript
const content = $input.item.json.content;
const toolUse = content.find(c => c.type === 'tool_use');
return [{ json: toolUse.input }];
```

That gives you clean JSON to route on.

## Getting started

Start with one workflow, not five. Pick the highest-volume repetitive task your team does — alert triage, ticket categorization, log summarization — and build that one workflow first. Get it stable. Then expand.

The pattern scales. The discipline of starting small doesn't change.

---

*I build n8n + Claude workflows as fixed-scope projects. If you have a specific ops problem you want to automate, describe it on the [contact page](/contact) and I'll tell you whether it fits a standard package or needs a custom scope.*
