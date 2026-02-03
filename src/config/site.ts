export const site = {
  name: import.meta.env.PUBLIC_SITE_NAME ?? "Vertex Chaos",
  url: import.meta.env.PUBLIC_SITE_URL ?? "https://vertexchaos.com",
  contactEmail: import.meta.env.PUBLIC_CONTACT_EMAIL ?? "hello@vertexchaos.com",
  linkedinUrl: import.meta.env.PUBLIC_LINKEDIN_URL ?? "https://www.linkedin.com/in/javalace/",
  githubUrl: import.meta.env.PUBLIC_GITHUB_URL ?? "https://github.com/vertex-chaos",
  location: import.meta.env.PUBLIC_LOCATION ?? "Sherwood, Oregon, USA",
  legalName:
    import.meta.env.PUBLIC_LEGAL_NAME ??
    "VERTEX CONSULTING HOLISTIC ADVISORY OPERATIONS SOLUTIONS, LLC",
} as const;

export const mailtoLink = `mailto:${site.contactEmail}`;
