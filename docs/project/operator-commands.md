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
powershell -ExecutionPolicy Bypass -File .\scaffold_update_2025-04-25.ps1 -TargetDir .\vertexchaos-site
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