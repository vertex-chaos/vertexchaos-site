export const site = {
  brand: "vertex_chaos",
  domain: "vertexchaos.com",
  domainLabel: "vertexchaos.com — consulting",
  email: "automation@vertexchaos.com",

  githubOrg: "vertex-chaos",
  githubOrgBase: "https://github.com/vertex-chaos",
  githubSiteRepo: "vertexchaos-site",
  githubSiteRepoUrl: "https://github.com/vertex-chaos/vertexchaos-site",

  headline: "Infrastructure automation,\ncloud operations, and practical AI.",
  subhead:
    "Practical fixes for small and mid-sized businesses. Windows, Linux, cloud, and hybrid environments. U.S.-based, remote-friendly.",

  trustItems: [
    "22+ years infrastructure and operations experience",
    "Upwork 100% Job Success",
    "U.S.-based, remote-friendly",
    "PowerShell · Python · Windows · Linux · Cloud",
  ],

  links: {
    email: "mailto:automation@vertexchaos.com",
    github: "https://github.com/vertex-chaos",
    portfolio: "/work",
    contact: "/contact",
    services: "/services",
  },

  nav: [
    { label: "Services", href: "/services" },
    { label: "Work", href: "/work" },
    { label: "Repos", href: "/repos" },
    { label: "About", href: "/about" },
  ],
} as const;
