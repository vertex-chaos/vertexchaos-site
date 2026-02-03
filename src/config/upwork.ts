export const upwork = {
  title: "Automation/DevOps Engineer | PowerShell | Python | CI/CD | AD",
  location: "Sherwood, Oregon, USA",
  rateNote: "Contact for quote",
  stats: [
    { label: "Job Success", value: "100%" },
    { label: "Public volume", value: "5 jobs / 38 hours" },
    { label: "Availability", value: "< 30 hrs/week" },
  ],
  overviewShort:
    "Automation/DevOps engineer with 22+ years building reliable infrastructure across Windows, Linux, and cloud. I focus on automation that reduces firefighting: CI/CD pipelines, Infrastructure as Code, and operational tooling that teams can maintain. Typical work includes GitHub Actions/Jenkins/Azure DevOps pipelines, Terraform/Ansible deployments, PowerShell and Python automation, and AD modernization at scale (cleanup, migrations, GPO hygiene). Clients consistently describe delivery as efficient, responsive, and well-documented.",
  overviewLong:
    "I build automation that makes infrastructure predictable: pipelines that ship safely, IaC that recreates environments consistently, and scripts/tools that eliminate repetitive operations. My background spans Windows and Linux systems, directory services, virtualization, and cloud deployments. I specialize in tying those together with CI/CD and automation so delivery doesn’t depend on tribal knowledge.\n\nCommon engagements include CI/CD pipelines (GitHub Actions/Jenkins/Azure DevOps), Terraform/Ansible foundations, PowerShell/Python automation, directory services hygiene and modernization, and small internal dashboards/reporting with Python/Django.\n\nI lead with outcomes and deliverables. You’ll get a clear plan, implementation in milestones, and documentation your team can use after handoff.",
  headlines: [
    "Automation/DevOps Engineer | PowerShell + Python | CI/CD + IaC",
    "CI/CD Pipelines (GitHub Actions/Jenkins/Azure DevOps) | Reliable Delivery",
    "Infrastructure Automation | Terraform/Ansible | Windows + Linux",
    "Active Directory Modernization | Cleanup + GPO Hygiene | Automation",
    "DevOps + Infrastructure | Cloud + On-Prem | Documentation-First",
    "PowerShell Automation | Ops Tooling | AD + Windows Server",
    "Python Automation | REST APIs | Internal Dashboards (Django)",
    "Azure + AWS Infrastructure | Terraform + CI/CD | Pragmatic Delivery",
    "Systems Automation | Monitoring + Reporting | PowerShell/Python",
    "Infrastructure Reliability | IaC + Pipelines | Maintainable Builds",
  ],
  specialized: [
    {
      name: "Directory services + PowerShell",
      text:
        "Modernize and automate directory environments: inventory, cleanup, policy hygiene, migrations, and guardrails. Expect safe scripts with logs, rollback notes, and documentation.",
    },
    {
      name: "CI/CD + IaC",
      text:
        "Design and stabilize delivery systems: pipelines, promotion strategies, validation gates, and Terraform/Ansible foundations that can be maintained long-term.",
    },
    {
      name: "Python/Django automation",
      text:
        "Internal tooling that makes ops visible: admin-only dashboards, reporting endpoints, and automation hooks with solid documentation.",
    },
  ],
  discoveryQuestions: [
    "What’s the primary pain: reliability, time, security, or all of the above?",
    "What environments exist (dev/test/prod) and how are releases done today?",
    "Which tools are required (GHA/Jenkins/Azure DevOps/Terraform/Ansible)?",
    "Who maintains this after delivery, and what’s their comfort level?",
    "Any access constraints (VPN, jump hosts, approvals, compliance)?",
    "What’s acceptable downtime or risk during rollout?",
    "What logging/monitoring exists today, and what’s missing?",
    "How will success be measured (time saved, fewer incidents, faster releases)?",
  ],
  catalog: [
    {
      title: "CI/CD Pipeline Build or Fix",
      tiers: [
        {
          name: "Basic",
          scope: [
            "Single pipeline (build/test/deploy)",
            "One environment",
            "Documentation + handoff notes",
          ],
        },
        {
          name: "Standard",
          scope: [
            "Multi-env promotion strategy",
            "Secrets handling guidance",
            "Validation gates + rollback notes",
            "Runbooks",
          ],
        },
        {
          name: "Premium",
          scope: [
            "Reusable pipeline templates",
            "Policy checks + quality gates",
            "Release runbooks + metrics",
            "Knowledge transfer session",
          ],
        },
      ],
    },
    {
      title: "Terraform/Ansible Foundation",
      tiers: [
        {
          name: "Basic",
          scope: ["Repo structure + baseline module/playbook", "One environment", "Docs"],
        },
        {
          name: "Standard",
          scope: [
            "Modules/playbooks + examples",
            "Two environments",
            "Runbooks + standards",
          ],
        },
        {
          name: "Premium",
          scope: [
            "Promotion workflow + linting",
            "CI integration",
            "Guardrails + documentation pack",
          ],
        },
      ],
    },
    {
      title: "Directory Hygiene Automation",
      tiers: [
        {
          name: "Basic",
          scope: ["Inventory + reporting", "Quick wins cleanup", "Docs"],
        },
        {
          name: "Standard",
          scope: ["Cleanup automation + policy hygiene", "Guardrails", "Runbooks"],
        },
        {
          name: "Premium",
          scope: [
            "Modernization plan",
            "Automation toolkit for ongoing use",
            "Handoff session",
          ],
        },
      ],
    },
  ],
  socialProof:
    "Multiple 5-star outcomes. Feedback consistently emphasizes efficiency, responsiveness, and clear communication (summarized, public-safe).",
} as const;
