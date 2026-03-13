// @ts-check
// CS340 Activity 2 - brooksc3
// Astro framework: https://astro.build/
// @astrojs/node adapter: https://docs.astro.build/en/guides/integrations-guide/node/

import { defineConfig } from 'astro/config';
import node from '@astrojs/node';

export default defineConfig({
  // SSR mode so db queries run server-side on each request
  output: 'server',

  // node adapter for SSR
  // https://www.npmjs.com/package/@astrojs/node
  adapter: node({
    mode: 'standalone'  // runs as its own server
  }),

  server: {
    host: '0.0.0.0',  // accept connections from any IP
    port: 8742        // my assigned port on classwork server
  }
});
