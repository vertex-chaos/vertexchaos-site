---
applyTo: "**/*.ps1"
---

- Prefer PowerShell 5.1+ compatible syntax unless the repo explicitly targets newer versions only.
- Use clear parameter validation and structured error handling.
- Make scripts idempotent where possible.
- Avoid non-ASCII characters unless explicitly required.
- Keep scripts operator-friendly and copy-pasteable.