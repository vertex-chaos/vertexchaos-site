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