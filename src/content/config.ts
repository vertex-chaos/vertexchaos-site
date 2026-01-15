import { defineCollection, z } from "astro:content";

const caseStudies = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    summary: z.string(),
    tags: z.array(z.string()).default([]),
    when: z.string().optional(),
    repo: z.string().optional(),
    kind: z.enum(["client", "lab", "open-source"]).default("client"),
  }),
});

export const collections = {
  "case-studies": caseStudies,
};
