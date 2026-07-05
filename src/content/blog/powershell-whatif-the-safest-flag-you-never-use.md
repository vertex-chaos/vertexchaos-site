---
title: "PowerShell -WhatIf: the safest flag you never use"
date: "2026-06-15"
summary: "Every destructive PowerShell script you run in production should have -WhatIf built in. Here is why most don't, and how to fix that in 10 minutes."
tags: ["PowerShell", "Windows", "Active Directory", "ops"]
draft: false
---

Every week someone in an IT Slack posts a screenshot of a script they ran that deleted the wrong things. Disabled the wrong accounts. Wiped the wrong OUs. The post always ends the same way: "is there a way to undo this?"

There isn't. But there was a way to not do it in the first place.

## What -WhatIf actually does

`-WhatIf` is a common parameter built into every cmdlet that modifies state — `Remove-ADUser`, `Set-ADUser`, `Move-ADObject`, `Disable-ADAccount`, all of them. When you pass it, the cmdlet prints what it *would* do and exits without touching anything.

```powershell
Get-ADUser -Filter { Enabled -eq $false -and LastLogonDate -lt "2024-01-01" } |
  Disable-ADAccount -WhatIf
```

Output:
```
What if: Performing the operation "Set" on target "CN=john.smith,OU=Users,DC=corp,DC=local".
What if: Performing the operation "Set" on target "CN=jane.doe,OU=Contractors,DC=corp,DC=local".
```

You get a full list of every object that would be touched. No changes made.

## The problem: most scripts don't support it

If you write a script with a bare `Remove-ADUser $user` inside a loop, `-WhatIf` doesn't propagate automatically. You have to wire it up yourself with `[CmdletBinding(SupportsShouldProcess)]`.

```powershell
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$OUPath,
    [int]$DaysInactive = 90
)

$cutoff = (Get-Date).AddDays(-$DaysInactive)
$stale = Get-ADUser -SearchBase $OUPath -Filter { LastLogonDate -lt $cutoff -and Enabled -eq $true }

foreach ($user in $stale) {
    if ($PSCmdlet.ShouldProcess($user.SamAccountName, "Disable account")) {
        Disable-ADAccount -Identity $user
        Write-Host "Disabled: $($user.SamAccountName)"
    }
}
```

Now `.\Disable-StaleAccounts.ps1 -OUPath "OU=Users,DC=corp,DC=local" -WhatIf` works correctly. Every action is gated behind `ShouldProcess`. Nothing runs until you remove `-WhatIf`.

## The pattern I use for every AD script

Three lines at the top of every script that touches AD:

```powershell
[CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
param(...)
```

`ConfirmImpact='High'` means PowerShell will prompt for confirmation on every action unless you explicitly pass `-Force`. Combined with `-WhatIf`, it gives you two safety rails: preview first, then confirm at execution.

## Why this matters at scale

At 10,000 users, a filter bug that's off by one day doesn't disable 2 accounts — it disables 800. The `LastLogonDate` attribute is replicated, not always current, and depends on which DC answered the query. I've seen clean-looking scripts hit 40% of an OU because the filter logic assumed `$null` meant "never logged in" when it actually meant "logged in before attribute tracking was enabled."

`-WhatIf` costs 30 seconds. The post-incident recovery costs days.

## The three scripts every AD shop should have -WhatIf on

1. **Stale account disable** — any user inactive >N days
2. **Group membership cleanup** — removing accounts from security groups in bulk
3. **OU moves** — restructuring after an org change or acquisition

These are the three that cause the most irreversible damage when they go wrong. If your versions don't have `-WhatIf` support, add it before you run them again.

---

*Need a stale account audit or AD cleanup for your environment? [Get in touch](/contact) — it's one of the fixed-price packages on the [services page](/services).*
