import { defineConfig } from 'astro/config';

import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: 'https://vertexchaos.com',
  trailingSlash: 'never',

  vite: {
    plugins: [tailwindcss()]
  }
});