import { defineCollection, z } from "astro:content";

const work = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    excerpt: z.string(),
    stack: z.array(z.string()).default([]),
    outcomes: z.array(z.string()).default([]),
  }),
});

export const collections = { work };
