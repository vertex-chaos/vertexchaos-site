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