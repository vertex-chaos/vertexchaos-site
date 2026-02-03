/// <reference types="astro/client" />

interface ImportMetaEnv {
  readonly PUBLIC_SITE_NAME?: string;
  readonly PUBLIC_SITE_URL?: string;
  readonly PUBLIC_CONTACT_EMAIL?: string;
  readonly PUBLIC_LINKEDIN_URL?: string;
  readonly PUBLIC_GITHUB_URL?: string;
  readonly PUBLIC_LOCATION?: string;
  readonly PUBLIC_LEGAL_NAME?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
