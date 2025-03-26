import { defineCollection, reference, z } from "astro:content";
import { glob } from "astro/loaders";

const phrases = defineCollection({
  loader: glob({ pattern: "**/[^_]*.md", base: "./src/phrases" }),
});

export const collections = { phrases };
