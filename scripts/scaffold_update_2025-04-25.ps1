#requires -Version 5.1
<#
filename: /mnt/data/scaffold_update_2025-04-25.ps1
purpose: scaffold and update the vertexchaos-site repo for Windows Server 2025 + VS Code
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [Alias("RepoPath", "Path")]
    [string]$TargetDir,

    [Parameter()]
    [string]$RepoUrl = "https://github.com/vertex-chaos/vertexchaos-site.git"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:Root = $null
$script:BackupDir = $null
$script:Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$script:DefaultTargetDir = "C:\Users\Administrator\repos\github\orgs\vertex-chaos\vertexchaos-site"
$script:TargetPathVariableName = "VERTEXCHAOS_SITE_PATH"

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message"
}

function Write-WarnMsg {
    param([string]$Message)
    Write-Warning $Message
}

function Fail-Now {
    param([string]$Message)
    throw $Message
}

function Test-CommandExists {
    param([string]$Name)
    $cmd = Get-Command -Name $Name -ErrorAction SilentlyContinue
    if (-not $cmd) {
        Fail-Now "Missing required command: $Name"
    }
}

function Get-EffectiveTargetDir {
    if ($PSBoundParameters.ContainsKey("TargetDir") -and -not [string]::IsNullOrWhiteSpace($TargetDir)) {
        return $TargetDir
    }

    $fromEnv = [Environment]::GetEnvironmentVariable($script:TargetPathVariableName)
    if (-not [string]::IsNullOrWhiteSpace($fromEnv)) {
        Write-Info "Using target path from environment variable $($script:TargetPathVariableName): $fromEnv"
        return $fromEnv
    }

    Write-Info "Using default target path: $($script:DefaultTargetDir)"
    return $script:DefaultTargetDir
}

function Resolve-TargetRoot {
    param([string]$InputPath)

    if ([System.IO.Path]::IsPathRooted($InputPath)) {
        return [System.IO.Path]::GetFullPath($InputPath)
    }

    return [System.IO.Path]::GetFullPath((Join-Path -Path (Get-Location) -ChildPath $InputPath))
}

function Ensure-Repo {
    if (Test-Path (Join-Path $script:Root ".git")) {
        Write-Info "Using existing git repo: $script:Root"
        return
    }

    if ((Test-Path $script:Root) -and -not (Test-Path (Join-Path $script:Root ".git"))) {
        Fail-Now "Target directory exists but is not a git repo: $script:Root"
    }

    Test-CommandExists -Name "git"
    Write-Info "Cloning repo from $RepoUrl"
    & git clone $RepoUrl $script:Root
    if ($LASTEXITCODE -ne 0) {
        Fail-Now "git clone failed"
    }
}

function Ensure-BackupDir {
    if (-not $script:BackupDir) {
        $script:BackupDir = Join-Path $script:Root ".scaffold-backups\$script:Timestamp"
        New-Item -ItemType Directory -Force -Path $script:BackupDir | Out-Null
    }
}

function Backup-IfExists {
    param([string]$Path)

    if (Test-Path -LiteralPath $Path -PathType Leaf) {
        Ensure-BackupDir
        $relative = [System.IO.Path]::GetRelativePath($script:Root, $Path)
        $dest = Join-Path $script:BackupDir $relative
        $destDir = Split-Path -Path $dest -Parent
        New-Item -ItemType Directory -Force -Path $destDir | Out-Null
        Copy-Item -LiteralPath $Path -Destination $dest -Force
    }
}

function Write-FileNormalized {
    param(
        [string]$Path,
        [string]$Content
    )

    $dir = Split-Path -Path $Path -Parent
    if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }

    $normalized = $Content -replace "`r`n", "`n"
    $existing = $null

    if (Test-Path -LiteralPath $Path -PathType Leaf) {
        $existing = [System.IO.File]::ReadAllText($Path)
        $existing = $existing -replace "`r`n", "`n"
    }

    if ($null -ne $existing -and $existing -eq $normalized) {
        Write-Info "Unchanged: $([System.IO.Path]::GetRelativePath($script:Root, $Path))"
        return
    }

    Backup-IfExists -Path $Path

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $normalized, $utf8NoBom)
    Write-Info "Wrote: $([System.IO.Path]::GetRelativePath($script:Root, $Path))"
}

function Ensure-Directories {
    $dirs = @(
        "docs\ai",
        "docs\architecture",
        "docs\business",
        "docs\project",
        "docs\site",
        "prompts",
        "scripts",
        ".vscode",
        ".github\instructions"
    )

    foreach ($dir in $dirs) {
        New-Item -ItemType Directory -Force -Path (Join-Path $script:Root $dir) | Out-Null
    }
}

$README = @'
# vertexchaos-site

Astro-based marketing site for Vertex Chaos, plus the working project skeleton for agent instructions, architecture notes, business packaging, and Day-1 execution planning.

## Purpose

This repo now serves two jobs:
- the public-facing `vertexchaos.com` website
- the internal operating template for productized consulting offers, AI agent setup, and architecture-first delivery

The repo already contains the website implementation, including Astro app structure under `src/`, homepage code in `src/pages/index.astro`, and brand config in `src/config/site.ts`. The scaffold adds reusable docs, cross-agent instruction files, project prompts, and an operating plan so the site repo can double as the active working system.

## What this repo now contains

```text
.
├── .github/
│   ├── copilot-instructions.md
│   └── instructions/
│       ├── docs.instructions.md
│       ├── powershell.instructions.md
│       └── python.instructions.md
├── .vscode/
│   ├── extensions.json
│   ├── settings.json
│   └── tasks.json
├── AGENTS.md
├── CLAUDE.md
├── GEMINI.md
├── README.md
├── docs/
│   ├── ai/
│   │   └── PROJECT_INSTRUCTIONS.md
│   ├── architecture/
│   │   ├── failure-modes.md
│   │   ├── overview.md
│   │   └── patterns-and-antipatterns.md
│   ├── business/
│   │   ├── delivery-checklist.md
│   │   ├── offer.md
│   │   └── pricing.md
│   ├── project/
│   │   ├── backlog.md
│   │   ├── brief.md
│   │   ├── decisions.md
│   │   ├── operator-commands.md
│   │   └── plan.md
│   └── site/
│       ├── brand-notes.md
│       └── homepage-copy.md
├── prompts/
│   ├── audit.md
│   ├── implementation.md
│   ├── proposal.md
│   └── report.md
├── scripts/
│   └── verify.ps1
├── src/
│   ├── config/site.ts
│   └── pages/index.astro
└── public/
```

## Documentation flow

```mermaid
flowchart TD
    A[README.md] --> B[docs/project/brief.md]
    A --> C[docs/project/plan.md]
    A --> D[docs/ai/PROJECT_INSTRUCTIONS.md]
    D --> E[CLAUDE.md]
    D --> F[AGENTS.md]
    D --> G[GEMINI.md]
    D --> H[.github/copilot-instructions.md]
    C --> I[docs/architecture/overview.md]
    C --> J[docs/architecture/patterns-and-antipatterns.md]
    C --> K[docs/architecture/failure-modes.md]
    B --> L[docs/business/offer.md]
    B --> M[docs/business/pricing.md]
    B --> N[docs/site/homepage-copy.md]
```

## Delivery flow

```mermaid
flowchart LR
    A[Lead or opportunity] --> B[Offer definition]
    B --> C[Brief]
    C --> D[Plan]
    D --> E[Architecture review]
    E --> F[Proposal or audit]
    F --> G[Implementation]
    G --> H[Report pack]
    H --> I[Reusable asset]
```

## Architecture guardrails

Every project doc in this repo should answer:
- what holds truth?
- what moves work?
- what retries?
- what fails first?
- what shortcut was tempting?
- why was it rejected or temporarily tolerated?
- when does the design stop being good enough?

The most important explicit antipattern to track is `database-as-a-queue`.

## Agent file strategy

One canonical instructions file lives at:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

Thin wrappers point tools at it:
- `CLAUDE.md`
- `AGENTS.md`
- `GEMINI.md`
- `.github/copilot-instructions.md`

## Day-1 outcome definition

A tool is only considered set up when it can:
1. read repo context
2. summarize structure accurately
3. create or edit one controlled file

## 90-minute operating mode

### Block 1: foundation
- review agent files and project docs
- verify Claude, Codex, and Gemini can read the repo
- perform one controlled doc edit with each tool

### Block 2: productization
- refine `docs/business/offer.md`
- refine `docs/business/pricing.md`
- refine `prompts/audit.md` and `prompts/proposal.md`

### Block 3: site credibility
- refine `docs/site/homepage-copy.md`
- then apply approved copy to `src/config/site.ts` and `src/pages/index.astro`

## Local dev

```powershell
npm install
npm run dev
```

## Build

```powershell
npm run build
npm run preview
```

## Verification

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify.ps1
```

## Recommended smoke tests

### Claude
- open repo
- summarize structure
- update `docs/project/plan.md` with one bullet

### Codex / ChatGPT coding agent
- open repo
- explain architecture files
- update `docs/project/backlog.md` with one task

### Gemini
- open repo
- summarize `docs/business/offer.md` and `docs/site/homepage-copy.md`
- add one improvement note to `docs/site/brand-notes.md`

## Operator commands

See:
- `docs/project/operator-commands.md`

## Important note

This scaffold is intentionally documentation-first. It prepares the repo for controlled execution, but it does not overwrite the public site implementation files yet. That happens after the copy and offer direction are approved.
'@

$PROJECT_INSTRUCTIONS = @'
# PROJECT INSTRUCTIONS

## Mission

Improve this project with a bias for:
- correctness
- maintainability
- security
- operational clarity
- reusable delivery assets

This project serves both as:
- the Vertex Chaos public website
- the internal operating template for productized consulting work

## Core Behavior

Always:
- inspect current files and patterns before changing anything
- preserve existing working behavior unless explicitly instructed otherwise
- prefer the smallest clean solution
- keep changes production-appropriate
- document decisions and tradeoffs
- keep architecture, operations, and business packaging explicit

Never:
- remove features unless explicitly told to do so
- hardcode secrets or environment-specific values
- add dependencies without clear justification
- silently change architecture or content direction without noting it
- present placeholder code as production-ready

## Architecture

Always identify:
- system of record
- async boundaries
- retry behavior
- idempotency requirements
- failure modes
- observability needs
- security boundaries

Avoid unless explicitly justified:
- database as a queue
- hidden cross-service coupling
- undocumented shared mutable state
- undocumented operator-only workflows
- retryable async work without idempotency guards

If a shortcut is temporarily accepted, record:
- where it exists
- why it exists
- why it is acceptable for now
- what triggers replacement

## Working Style

For non-trivial work, reason in this order:
1. current state
2. problem
3. constraints
4. options
5. recommendation
6. implementation plan
7. validation plan
8. rollback or recovery notes

## Business Context

Brand:
- Vertex Chaos
- vertexchaos.com

Legal entity:
- VERTEX CONSULTING HOLISTIC ADVISORY OPERATIONS SOLUTIONS, LLC

Primary near-term objective:
- productize one technical service fast enough to support at least $1,000 USD/week in side-hustle revenue

Current best service lanes:
- Cloudflare / DNS / email / exposure audit
- AD / Windows Server health review
- Docker deployment / CI-CD / Linux cleanup

## Output Standards

Prefer outputs that are:
- direct
- technically precise
- practical over theoretical
- explicit about tradeoffs
- reusable in future delivery

Documentation should be sufficient for:
- a human operator
- another AI tool
- a future proposal or audit deliverable
'@

$CLAUDE = @'
# CLAUDE.md

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Claude-Specific Rules

- Treat `docs/ai/PROJECT_INSTRUCTIONS.md` as the primary source of truth.
- Inspect current repository structure before making changes.
- Prefer minimal, coherent edits.
- Do not remove existing working features unless explicitly instructed.
- For architecture work, explicitly identify current state, target state, tradeoffs, failure modes, and migration steps.
- For async workflows, check queue semantics, idempotency, retries, and ownership.
- State assumptions clearly instead of pretending certainty.
'@

$AGENTS = @'
# AGENTS.md

This file governs the entire repository.

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Agent Rules

- Inspect code and docs before editing.
- Preserve working behavior unless explicitly told otherwise.
- Prefer minimal, production-sensible changes.
- Do not invent missing requirements.
- Do not hardcode secrets, credentials, or environment-specific endpoints.
- Do not silently introduce architecture changes without documenting them.

## Required Checks

For non-trivial changes, verify:
- data ownership
- failure behavior
- retry behavior
- idempotency where relevant
- configuration impact
- deployment and operations impact
'@

$GEMINI = @'
# GEMINI.md

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Gemini Usage Notes

Use Gemini primarily for:
- summarizing repository structure
- drafting or tightening documentation
- comparing copy variants
- producing scoped improvement suggestions

Do not:
- broaden project scope without instruction
- replace existing architecture reasoning with generic boilerplate
- overwrite implementation files until the proposed copy or plan is approved
'@

$COPILOT = @'
# Copilot Repository Instructions

Read and follow:
- `docs/ai/PROJECT_INSTRUCTIONS.md`

## Repository Rules

- Make the smallest clean change that solves the problem.
- Follow the repository's existing structure and conventions.
- Do not remove features unless explicitly instructed.
- Keep secrets and environment-specific values out of source files.
- Keep code, docs, and operations explicit.

## Architecture Rules

When changing architecture-related code or docs:
- identify the system of record
- identify async boundaries
- identify retry and idempotency requirements
- call out risky patterns, including database-as-a-queue

## Documentation Rules

When changing behavior, update relevant docs if present:
- architecture docs
- runbooks
- config examples
- operational notes
'@

$PYTHON_INSTRUCTIONS = @'
---
applyTo: "**/*.py"
---

- Prefer explicit, typed, maintainable Python.
- Keep functions focused and predictable.
- Add validation and useful error messages.
- Avoid unnecessary abstraction.
- Keep side effects visible.
'@

$POWERSHELL_INSTRUCTIONS = @'
---
applyTo: "**/*.ps1"
---

- Prefer PowerShell 5.1+ compatible syntax unless the repo explicitly targets newer versions only.
- Use clear parameter validation and structured error handling.
- Make scripts idempotent where possible.
- Avoid non-ASCII characters unless explicitly required.
- Keep scripts operator-friendly and copy-pasteable.
'@

$DOCS_INSTRUCTIONS = @'
---
applyTo: "**/*.md"
---

- Prefer direct, technically precise writing.
- Keep business context and technical context consistent.
- Record tradeoffs explicitly.
- Keep architecture documents reusable by both humans and AI tools.
'@

$VSCODE_SETTINGS = @'
{
  "files.eol": "\n",
  "files.insertFinalNewline": true,
  "editor.formatOnSave": true,
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.tabs.enabled": true,
  "markdown.preview.breaks": true,
  "powershell.powerShellDefaultVersion": "Windows PowerShell"
}
'@

$VSCODE_EXTENSIONS = @'
{
  "recommendations": [
    "astro-build.astro-vscode",
    "esbenp.prettier-vscode",
    "github.copilot",
    "github.copilot-chat",
    "ms-vscode.powershell",
    "yzhang.markdown-all-in-one"
  ]
}
'@

$VSCODE_TASKS = @'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "site:dev",
      "type": "shell",
      "command": "npm run dev",
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": []
    },
    {
      "label": "site:build",
      "type": "shell",
      "command": "npm run build",
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": []
    },
    {
      "label": "repo:verify",
      "type": "shell",
      "command": "powershell -ExecutionPolicy Bypass -File .\\scripts\\verify.ps1",
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "problemMatcher": []
    }
  ]
}
'@

$EDITORCONFIG = @'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
'@

$ARCH_OVERVIEW = @'
# Architecture Overview

## Current System

This repository currently contains:
- an Astro static site for vertexchaos.com
- source implementation under `src/`
- deployment target of Cloudflare Pages
- repo-level configuration in `.github/`

## Current Purpose

The repo now also serves as:
- the source of truth for website messaging
- the AI instruction layer for Claude, Copilot, Codex-style agents, and Gemini
- the working archive for offers, prompts, architecture notes, and delivery process

## System of Record

- Website implementation: this repository
- Business positioning and offer drafts: `docs/business/`
- Architecture guidance: `docs/architecture/`
- Agent operating guidance: `docs/ai/PROJECT_INSTRUCTIONS.md`

## Next Planned Execution Layer

After content approval:
- update `src/config/site.ts`
- update `src/pages/index.astro`
- optionally add or tighten `/services`, `/about`, and `/contact`
'@

$ARCH_PATTERNS = @'
# Patterns and Antipatterns

## Required Tracking Questions

Every meaningful project change should answer:
- what holds truth?
- what moves work?
- what retries?
- what fails first?
- what shortcut is tempting?
- why reject it or tolerate it temporarily?
- when must it be replaced?

## Explicit Antipattern Register

### database-as-a-queue

#### Description
Using the primary application database as a generic work-dispatch mechanism by polling rows for pending work.

#### Risks
- wasted polling load
- row-locking complexity
- fragile retry semantics
- queue churn harming the primary workload
- messy recovery logic

#### Rule
Do not tolerate this casually. If temporarily accepted, record:
- where it exists
- why it exists
- why it is acceptable for now
- what metric or event triggers replacement
'@

$ARCH_FAILURE = @'
# Failure Modes

## Current Likely Failure Areas

### Messaging drift
- site copy, offer docs, and prompts fall out of sync
- mitigation: keep copy source in `docs/site/` and offers in `docs/business/`

### Agent drift
- different AI tools produce conflicting structure or edits
- mitigation: one canonical instructions file plus thin wrappers

### Premature execution
- implementation starts before positioning and offer scope are approved
- mitigation: keep plan mode explicit and gate site code changes behind approved copy

### Repo clutter
- docs multiply without becoming actionable
- mitigation: every new doc must tie to delivery, site publication, or reusable service packaging
'@

$BUSINESS_OFFER = @'
# Productized Offer Draft

## Candidate Primary Offer

### Cloudflare / DNS / Email Exposure Audit

#### Outcome
Identify obvious exposure, misconfiguration, routing, DNS, email, and web edge risks quickly and turn them into a prioritized remediation plan.

#### Deliverables
- current-state findings summary
- prioritized issues list
- remediation recommendations
- implementation sequence
- optional live walkthrough

#### Who It Fits
- small and mid-sized businesses
- owner-led teams
- companies with messy inherited DNS or web exposure setup
- teams unsure whether mail, DNS, or Cloudflare is configured cleanly
'@

$BUSINESS_PRICING = @'
# Pricing Draft

## Initial Direction

Keep pricing simple enough to sell fast.

### Option A
- one fixed-scope audit around the $500 to $1,000 range

### Option B
- one smaller diagnostic offer around the $300 to $500 range
- one implementation follow-up scoped separately

## Rule
Pricing must match:
- low-friction first purchase
- strong perceived clarity
- clear deliverables
- easy conversion into follow-up work
'@

$BUSINESS_CHECKLIST = @'
# Delivery Checklist

## Before starting
- confirm problem statement
- confirm scope boundaries
- confirm access level
- confirm expected outputs

## During delivery
- document assumptions
- document risks
- record current state before proposing target state
- keep remediation steps explicit

## Before closing
- provide summary
- provide prioritized next steps
- identify quick wins
- identify follow-on work candidates
'@

$PROJECT_BRIEF = @'
# Project Brief

## Immediate Goal
Use the existing `vertexchaos-site` repo at `C:\Users\Administrator\repos\github\orgs\vertex-chaos\vertexchaos-site` as the working base for:
- cross-agent AI setup
- reusable consulting delivery docs
- faster website credibility improvements

## Day-1 Objectives
1. working AI environment
2. reusable template foundation inside the repo
3. professional site messaging direction
'@

$PROJECT_PLAN = @'
# Plan

## 90-Minute Operating Mode

### Block 1
- review scaffolded docs
- validate agent files
- test one controlled edit with one AI tool

### Block 2
- refine business offer and pricing
- tighten homepage copy

### Block 3
- apply approved copy into site implementation files
- verify local build still works
'@

$PROJECT_DECISIONS = @'
# Decisions

- Active project repo is `vertexchaos-site`
- Do not split into a separate template repo yet
- Repo acts as both public site source and internal delivery template
- Keep documentation-first until homepage and service copy are approved
'@

$PROJECT_BACKLOG = @'
# Backlog

- tighten homepage messaging for consulting conversion
- define 3 productized offers
- update `src/config/site.ts`
- update `src/pages/index.astro`
- evaluate `/services` page structure
'@

$PROJECT_COMMANDS = @'
# Operator Commands

## First sync

```powershell
git fetch origin
git checkout main
git pull --ff-only origin main
git status
```

## Run scaffold

```powershell
powershell -ExecutionPolicy Bypass -File .\scaffold_update_2025-04-25.ps1 -TargetDir "C:\Users\Administrator\repos\github\orgs\vertex-chaos\vertexchaos-site"
```

## Review changes

```powershell
git status
git diff -- README.md CLAUDE.md AGENTS.md GEMINI.md .github/copilot-instructions.md docs/
```

## Local site validation

```powershell
npm install
npm run dev
npm run build
powershell -ExecutionPolicy Bypass -File .\scripts\verify.ps1
```

## Branch and commit

```powershell
git checkout -b feat/day1-agent-and-doc-scaffold
git add README.md CLAUDE.md AGENTS.md GEMINI.md .editorconfig .github .vscode docs prompts scripts
git commit -m "Add agent docs and Day-1 operating scaffold"
```
'@

$SITE_HOMEPAGE = @'
# Homepage Copy Draft

## Hero

### Heading
Infrastructure automation, cloud operations, and practical AI implementation for real businesses.

### Subtext
Help small and mid-sized organizations fix messy infrastructure, automate repetitive operations, and ship reliable systems across Windows, Linux, cloud, and hybrid environments.

### Primary CTA
Book a consultation

### Secondary CTA
See services

## Trust Strip
- 22+ years infrastructure and operations experience
- PowerShell, Python, Active Directory, Windows Server, Linux, CI/CD
- Upwork 100% Job Success
- U.S.-based, remote-friendly

## Services

### Infrastructure & Systems
Active Directory, Windows Server, DNS, email, backup, virtualization, migrations, cleanup, hardening.

### Automation & DevOps
PowerShell and Python automation, Docker and deployment cleanup, CI/CD workflows, operational tooling.

### AI Enablement
Practical AI workflow integration, coding-agent setup, internal tool acceleration, documentation and execution systems.

## CTA
Need a sharp operator, not another vague consultant?

I deliver practical fixes, clean automation, and systems that are easier to run tomorrow than they are today.
'@

$SITE_BRAND = @'
# Brand Notes

## Positioning
Vertex Chaos should read as:
- practical
- senior
- calm under operational mess
- explicit, not flashy

## Avoid
- vague innovation language
- generic AI hype
- over-designed copy that hides the actual services
'@

$PROMPT_PROPOSAL = @'
# Proposal Prompt

Write a concise technical proposal for a consulting opportunity using the project brief, offer definition, and pricing direction in this repository.
'@

$PROMPT_AUDIT = @'
# Audit Prompt

Draft a practical audit structure with findings, risks, quick wins, and recommended next steps based on the active offer and architecture docs in this repository.
'@

$PROMPT_IMPLEMENTATION = @'
# Implementation Prompt

Propose the smallest coherent implementation plan based on the approved brief, architecture notes, and site copy in this repository.
'@

$PROMPT_REPORT = @'
# Report Prompt

Create a client-facing report outline with executive summary, findings, risk ranking, remediation plan, and optional follow-up scope.
'@

$VERIFY_PS1 = @'
#requires -Version 5.1
<#
filename: scripts/verify.ps1
purpose: verify the core scaffold files exist
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "[INFO] Repo root: $(Get-Location)"

$required = @(
    "README.md",
    "CLAUDE.md",
    "AGENTS.md",
    "GEMINI.md",
    ".github/copilot-instructions.md",
    "docs/ai/PROJECT_INSTRUCTIONS.md",
    "docs/architecture/overview.md",
    "docs/business/offer.md",
    "docs/project/plan.md",
    "docs/site/homepage-copy.md"
)

foreach ($path in $required) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing required file: $path"
    }

    Write-Host "[INFO] Found: $path"
}

if (Test-Path -LiteralPath "package.json" -PathType Leaf) {
    Write-Host "[INFO] package.json present"
}
else {
    Write-Warning "package.json not found"
}

Write-Host "[INFO] Verification complete"
'@

function Main {
    $resolvedTargetInput = Get-EffectiveTargetDir
    $script:Root = Resolve-TargetRoot -InputPath $resolvedTargetInput

    Test-CommandExists -Name "git"
    Ensure-Repo
    Ensure-Directories

    Write-FileNormalized -Path (Join-Path $script:Root "README.md") -Content $README
    Write-FileNormalized -Path (Join-Path $script:Root "docs\ai\PROJECT_INSTRUCTIONS.md") -Content $PROJECT_INSTRUCTIONS
    Write-FileNormalized -Path (Join-Path $script:Root "CLAUDE.md") -Content $CLAUDE
    Write-FileNormalized -Path (Join-Path $script:Root "AGENTS.md") -Content $AGENTS
    Write-FileNormalized -Path (Join-Path $script:Root "GEMINI.md") -Content $GEMINI
    Write-FileNormalized -Path (Join-Path $script:Root ".github\copilot-instructions.md") -Content $COPILOT
    Write-FileNormalized -Path (Join-Path $script:Root ".github\instructions\python.instructions.md") -Content $PYTHON_INSTRUCTIONS
    Write-FileNormalized -Path (Join-Path $script:Root ".github\instructions\powershell.instructions.md") -Content $POWERSHELL_INSTRUCTIONS
    Write-FileNormalized -Path (Join-Path $script:Root ".github\instructions\docs.instructions.md") -Content $DOCS_INSTRUCTIONS
    Write-FileNormalized -Path (Join-Path $script:Root ".vscode\settings.json") -Content $VSCODE_SETTINGS
    Write-FileNormalized -Path (Join-Path $script:Root ".vscode\extensions.json") -Content $VSCODE_EXTENSIONS
    Write-FileNormalized -Path (Join-Path $script:Root ".vscode\tasks.json") -Content $VSCODE_TASKS
    Write-FileNormalized -Path (Join-Path $script:Root ".editorconfig") -Content $EDITORCONFIG
    Write-FileNormalized -Path (Join-Path $script:Root "docs\architecture\overview.md") -Content $ARCH_OVERVIEW
    Write-FileNormalized -Path (Join-Path $script:Root "docs\architecture\patterns-and-antipatterns.md") -Content $ARCH_PATTERNS
    Write-FileNormalized -Path (Join-Path $script:Root "docs\architecture\failure-modes.md") -Content $ARCH_FAILURE
    Write-FileNormalized -Path (Join-Path $script:Root "docs\business\offer.md") -Content $BUSINESS_OFFER
    Write-FileNormalized -Path (Join-Path $script:Root "docs\business\pricing.md") -Content $BUSINESS_PRICING
    Write-FileNormalized -Path (Join-Path $script:Root "docs\business\delivery-checklist.md") -Content $BUSINESS_CHECKLIST
    Write-FileNormalized -Path (Join-Path $script:Root "docs\project\brief.md") -Content $PROJECT_BRIEF
    Write-FileNormalized -Path (Join-Path $script:Root "docs\project\plan.md") -Content $PROJECT_PLAN
    Write-FileNormalized -Path (Join-Path $script:Root "docs\project\decisions.md") -Content $PROJECT_DECISIONS
    Write-FileNormalized -Path (Join-Path $script:Root "docs\project\backlog.md") -Content $PROJECT_BACKLOG
    Write-FileNormalized -Path (Join-Path $script:Root "docs\project\operator-commands.md") -Content $PROJECT_COMMANDS
    Write-FileNormalized -Path (Join-Path $script:Root "docs\site\homepage-copy.md") -Content $SITE_HOMEPAGE
    Write-FileNormalized -Path (Join-Path $script:Root "docs\site\brand-notes.md") -Content $SITE_BRAND
    Write-FileNormalized -Path (Join-Path $script:Root "prompts\proposal.md") -Content $PROMPT_PROPOSAL
    Write-FileNormalized -Path (Join-Path $script:Root "prompts\audit.md") -Content $PROMPT_AUDIT
    Write-FileNormalized -Path (Join-Path $script:Root "prompts\implementation.md") -Content $PROMPT_IMPLEMENTATION
    Write-FileNormalized -Path (Join-Path $script:Root "prompts\report.md") -Content $PROMPT_REPORT
    Write-FileNormalized -Path (Join-Path $script:Root "scripts\verify.ps1") -Content $VERIFY_PS1

    Write-Info "Scaffold complete"
    Write-Info "Next commands:"
    Write-Host "  Set-Location '$script:Root'"
    Write-Host "  git status"
    Write-Host "  powershell -ExecutionPolicy Bypass -File .\scripts\verify.ps1"
    Write-Host "  npm install"
    Write-Host "  npm run dev"

    if ($script:BackupDir) {
        Write-Info "Backups stored under: $script:BackupDir"
    }
}

Main
