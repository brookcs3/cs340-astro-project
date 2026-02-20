# Astro Basics for Our CS340 Project

Hey Brayden — this doc covers the fundamentals of Astro as it applies to our project. You don't need to learn everything about Astro, just enough to understand how our pages work and how to make changes.

## What is Astro?

Astro is a web framework (like Express or Flask) but with a built-in templating system. Think of it as a modern replacement for the Handlebars + Express combo that CS340 suggests. The key thing: **Astro pages are `.astro` files that combine server-side code and HTML in one file.**

## The `.astro` File Structure

Every `.astro` file has two parts separated by `---` fences:

```astro
---
// FRONTMATTER (server-side JavaScript/TypeScript)
// This runs on the server BEFORE the HTML is sent to the browser.
// Database queries, form handling, imports — all go here.

import Layout from '../layouts/Layout.astro';
const message = "Hello from the server!";
---

<!-- TEMPLATE (HTML sent to the browser) -->
<!-- You can use {expressions} to inject server-side values -->
<Layout title="My Page">
  <h1>{message}</h1>
</Layout>
```

**Key concept:** The frontmatter (`---` block) runs on the server. The template below it is the HTML that gets sent to the user's browser. The user never sees the frontmatter code.

## Our Project Structure

```
src/
├── layouts/
│   └── Layout.astro        ← Shared wrapper (nav bar, <head>, styles)
├── lib/
│   └── db.ts               ← Database connection helper
├── pages/
│   ├── index.astro          ← Homepage (/)
│   ├── players.astro        ← /players
│   ├── games.astro          ← /games
│   ├── platforms.astro      ← /platforms
│   ├── run-categories.astro ← /run-categories
│   ├── run-submissions.astro← /run-submissions
│   └── games-on-platforms.astro ← /games-on-platforms
astro.config.mjs             ← Config (SSR mode, port 8742)
.env                         ← Database credentials (not in git!)
```

**File-based routing:** The file name = the URL. `src/pages/players.astro` becomes `http://localhost:8742/players`. That's it — no router config needed.

## Layouts

Our `Layout.astro` wraps every page with the nav bar, `<head>` tags, and styles:

```astro
---
const { title } = Astro.props;
---
<html>
<head><title>{title}</title></head>
<body>
  <nav><!-- nav links --></nav>
  <main>
    <slot />   <!-- THIS IS WHERE THE PAGE CONTENT GOES -->
  </main>
</body>
</html>
```

When a page does `<Layout title="Players">...content...</Layout>`, the `...content...` gets inserted where `<slot />` is.

## SSR Mode

Our project runs in **Server-Side Rendering (SSR)** mode, meaning every page request hits the server, runs the frontmatter, queries the database, and returns fresh HTML. This is set in `astro.config.mjs`:

```js
export default defineConfig({
  output: 'server',           // SSR mode
  adapter: node({             // Node.js server adapter
    mode: 'standalone'
  }),
  server: {
    port: 8742,
    host: '0.0.0.0'
  }
});
```

## Running the Dev Server

```bash
npm run dev
```

This starts a local dev server at `http://localhost:8742`. It hot-reloads when you save changes — no restart needed.

## Key Differences from Plain HTML

| Plain HTML | Astro |
|---|---|
| Static files served by Apache/Nginx | Server renders pages on each request |
| JavaScript runs in the browser | Frontmatter code runs on the server |
| Need separate API endpoints | Database queries go right in the page |
| Forms submit to a separate route | Forms POST to the same page |

## Next Steps

- Read `02-mysql-integration.md` to understand how we connect to the database
- Read `03-crud-patterns.md` to see how the forms and database queries work together
