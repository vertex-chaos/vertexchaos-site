export const tagline =
  "Infrastructure that works. Documented on purpose. Automation that reduces noise and makes changes boring.";

export const intro = {
  headline: "Automation & DevOps engineering for reliable infrastructure",
  subhead:
    "CI/CD, infrastructure-as-code, and pragmatic automation across Windows, Linux, and cloud. Clean deliverables. Clear documentation. No mystery meat.",
  bullets: [
    "Pipelines that ship safely (GitHub Actions, Jenkins, Azure DevOps)",
    "IaC foundations that are repeatable (Terraform, Ansible)",
    "Automation + monitoring that removes manual work (PowerShell, Python)",
    "Active Directory modernization at scale (cleanup, GPO hygiene, migrations)",
    "Cloud deployments (Azure + AWS) with operational guardrails",
    "Internal tooling (Python/Django) for dashboards and reporting",
  ],
  proof: [
    { label: "Experience", value: "22+ years" },
    { label: "Upwork", value: "100% Job Success" },
    { label: "Public volume", value: "5 jobs / 38 hours" },
    { label: "Availability", value: "< 30 hrs/week" },
  ],
};

export const services = [
  {
    title: "CI/CD pipelines",
    blurb:
      "Build or stabilize pipelines that deploy safely and predictably. Less manual clicking. Fewer surprises.",
    deliverables: [
      "Pipeline design + implementation (build/test/deploy)",
      "Promotion strategy (dev/test/prod) and rollback notes",
      "Secrets handling guidance and secure patterns",
      "Runbooks and handoff documentation",
    ],
    tags: ["GitHub Actions", "Jenkins", "Azure DevOps"],
  },
  {
    title: "Infrastructure as Code",
    blurb:
      "Terraform/Ansible foundations that reproduce environments consistently. Modules/playbooks your team can maintain.",
    deliverables: [
      "Repo structure + standards for environments",
      "Reusable modules/playbooks with sane defaults",
      "Validation/linting and CI hooks (optional)",
      "Documentation + examples for ongoing work",
    ],
    tags: ["Terraform", "Ansible"],
  },
  {
    title: "Automation + monitoring",
    blurb:
      "PowerShell/Python automation that removes repetitive ops work, with logging and safety built in.",
    deliverables: [
      "Scripts/tools with idempotent behavior where possible",
      "Structured logging + error handling",
      "Health checks and reporting outputs",
      "Docs + usage examples",
    ],
    tags: ["PowerShell", "Python"],
  },
  {
    title: "Active Directory modernization",
    blurb:
      "Cleanup and standardization for large AD environments, plus automation to keep it from regressing.",
    deliverables: [
      "Inventory + reporting (users/groups/computers/GPOs)",
      "Cleanup automation (stale objects, GPO hygiene)",
      "Standards and guardrails (OU/GPO practices)",
      "Documentation and handoff notes",
    ],
    tags: ["Active Directory", "GPO/GPP"],
  },
  {
    title: "Cloud deployments",
    blurb:
      "Azure/AWS deployments with operational sanity: identity, logging, cost visibility, and a clean path to operate it.",
    deliverables: [
      "Deployment plan + minimal viable architecture",
      "Identity integration patterns (where applicable)",
      "Operational hardening (logs, backups, alerts)",
      "Documentation + runbooks",
    ],
    tags: ["Azure", "AWS"],
  },
  {
    title: "Internal tooling",
    blurb:
      "Small, focused dashboards and reporting to make ops visible. Admin-only, practical, and maintainable.",
    deliverables: [
      "Django-based admin/dashboard scaffold (optional)",
      "REST endpoints for automation/reporting",
      "Basic auth/audit logging patterns",
      "Deployment notes + docs",
    ],
    tags: ["Python", "Django", "REST APIs"],
  },
];

export const processSteps = [
  {
    title: "Confirm outcomes",
    text:
      "We agree on what success looks like: measurable, testable, and tied to deliverables.",
  },
  {
    title: "Map the constraints",
    text:
      "Access, compliance, tooling, deadlines. If something blocks delivery, we surface it early.",
  },
  {
    title: "Ship in milestones",
    text:
      "Small, reviewable increments. Each step leaves the system better than it was.",
  },
  {
    title: "Handoff with docs",
    text:
      "Runbooks, diagrams, and “how to not break it later” notes. Teams deserve that.",
  },
];

export const contactNeeds = [
  "Target environment details (Windows/Linux/cloud, versions, constraints)",
  "Preferred tooling (GHA/Jenkins/Azure DevOps, Terraform/Ansible, etc.)",
  "Access method (VPN, jump host, repo access, approvals)",
  "Definition of done (success criteria)",
  "Timeline and any hard deadlines",
  "Any existing scripts/pipelines/configs to review",
];
