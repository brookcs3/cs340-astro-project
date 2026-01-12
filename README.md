# CS340 Activity 2 - Astro + MySQL

This is the foundation for our CS340 project. It's a bit overengineered for Activity 2, but that means we have a solid starting point to build on.

**Live URL:** http://classwork.engr.oregonstate.edu:8742/

---

## What is Astro?

Astro is a modern web framework that's really beginner-friendly. Think of it as "HTML with superpowers." You write `.astro` files that look like regular HTML, but you can add JavaScript at the top (in the "frontmatter" between the `---` fences) that runs on the server.

**Key things to know:**
- Files in `src/pages/` automatically become routes (e.g., `index.astro` → `/`, `about.astro` → `/about`)
- The stuff between `---` at the top runs on the server (where we do our MySQL queries)
- Everything below the `---` is your HTML template
- You can use `{variable}` syntax to inject JavaScript values into HTML

**Official Docs:** https://docs.astro.build/

---

## Prerequisites

Before you start, make sure you have:

1. **Node.js** (v18 or higher recommended)
   - Check: `node --version`
   - Install: https://nodejs.org/ or use `nvm` (Node Version Manager)

2. **npm** (comes with Node.js)
   - Check: `npm --version`

3. **Git**
   - Check: `git --version`

---

## Getting Started

### 1. Clone the Repository

```bash
git clone git@github.com:brookcs3/cs340-astro-project.git
cd cs340-astro-project
```

Or if you prefer HTTPS:
```bash
git clone https://github.com/brookcs3/cs340-astro-project.git
cd cs340-astro-project
```

### 2. Install Dependencies

```bash
npm install
```

This downloads all the packages listed in `package.json` into `node_modules/`. Takes a minute the first time.

### 3. Create Your `.env` File

The database credentials are NOT in the repo (for security). Create a `.env` file in the project root:

```bash
touch .env
```

Then add your credentials (I'll share these with you separately):

```
MYSQL_HOST=your_host
MYSQL_USER=your_username
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=your_database
```

---

## Running the Development Server (Hot Reload)

This is where the magic happens. Run:

```bash
npm run dev
```

You'll see something like:
```
┃ Local    http://localhost:4321/
┃ Network  use --host to expose
```

Open http://localhost:4321 in your browser.

### What is Hot Reload?

When the dev server is running, **any changes you make to files automatically refresh in your browser**. No need to manually refresh or restart the server.

### Hot Reload Test (Try This!)

With `npm run dev` running:

1. Open `src/pages/index.astro` in your editor
2. Find this line (around line 193):
   ```html
   <h1 data-text="MySQL Results">MySQL Results</h1>
   ```
3. Change it to:
   ```html
   <h1 data-text="MySQL Results">Hello Brayden!</h1>
   ```
4. Save the file
5. Watch your browser - it should update automatically within 1-2 seconds!
6. Change it back when you're done testing

**Note:** Hot reload works for HTML/CSS/JS changes. If you change the MySQL queries in the frontmatter, the page will also refresh automatically since SSR re-runs the server code on each request.

---

## npm Scripts Explained

These are defined in `package.json`:

| Command | What it does |
|---------|--------------|
| `npm run dev` | Starts development server with hot reload at http://localhost:4321 |
| `npm run build` | Compiles project for production into `dist/` folder |
| `npm run preview` | Preview the production build locally |
| `npx astro` | Direct access to Astro CLI (e.g., `npx astro --help`) |

### `npm run dev` vs `npm run build`

- **`npm run dev`**: For development. Fast, has hot reload, shows detailed errors. Don't use for production.
- **`npm run build`**: Creates optimized production files. Outputs to `dist/` folder. This is what we deploy to the server.

You can also use the Astro CLI directly:
```bash
npx astro dev      # same as npm run dev
npx astro build    # same as npm run build
npx astro preview  # same as npm run preview
```

---

## Project Structure

```
cs340-astro-project/
├── src/
│   └── pages/
│       └── index.astro      # Main page (this is what you see at /)
├── dist/                    # Production build output (gitignored)
├── node_modules/            # Dependencies (gitignored)
├── .astro/                  # Astro cache (gitignored)
├── .env                     # Database credentials (gitignored - create your own!)
├── astro.config.mjs         # Astro configuration
├── package.json             # Project dependencies and scripts
├── tsconfig.json            # TypeScript config
├── deploy.sh                # Deployment script (for classwork server)
└── README.md                # You are here!
```

---

## How the MySQL Connection Works

This is where our setup differs from a "standard" Astro project. Normally Astro generates static HTML at build time. We needed it to run MySQL queries on each request.

### The SSR Setup

In `astro.config.mjs`, we enabled **Server-Side Rendering (SSR)**:

```javascript
import { defineConfig } from 'astro/config';
import node from '@astrojs/node';

export default defineConfig({
  // SSR mode - pages are rendered on each request, not at build time
  output: 'server',

  // Node adapter - lets Astro run as a Node.js server
  adapter: node({
    mode: 'standalone'  // Runs as its own server
  }),

  server: {
    host: '0.0.0.0',    // Accept connections from any IP
    port: 8742          // Our assigned port on classwork server
  }
});
```

**Key points:**
- `output: 'server'` means pages render on every request (not pre-built)
- `@astrojs/node` adapter makes Astro work as a Node.js server
- This is required because MySQL queries need to run on the server, not in the browser

### The MySQL Query

In `src/pages/index.astro`, the frontmatter (between `---`) runs on the server:

```javascript
---
import mysql from 'mysql2/promise';

// Connect using credentials from .env file
const connection = await mysql.createConnection({
  host: import.meta.env.MYSQL_HOST,
  user: import.meta.env.MYSQL_USER,
  password: import.meta.env.MYSQL_PASSWORD,
  database: import.meta.env.MYSQL_DATABASE,
});

// Run queries
await connection.execute('DROP TABLE IF EXISTS diagnostic');
await connection.execute('CREATE TABLE diagnostic(...)');
await connection.execute('INSERT INTO diagnostic (text) VALUES (...)');
const [rows] = await connection.execute('SELECT * FROM diagnostic');

await connection.end();
---
```

The `rows` variable is then available in the HTML template below:
```html
<p class="result-value">{JSON.stringify(rows, null, 2)}</p>
```

**Important:** The `import.meta.env.VARIABLE_NAME` syntax reads from your `.env` file.

---

## About the Styling (It's a Bit Extra)

Yeah, the styling is... a lot. I borrowed it from another project. Here's what's going on:

### The Red Gradient Background

```css
background: radial-gradient(120% 100% at 50% 10%,
  color(display-p3 0.827451 0.043137 0.043137) 0%,
  var(--bg) 45%,
  color(display-p3 0.556863 0.015686 0.015686) 100%);
```

This creates a deep red gradient. The `display-p3` color space gives richer reds on supported displays.

### The 3D Animations

```css
.stage {
  perspective: 1000px;
  transform-style: preserve-3d;
  animation: microTilt 3s ease-in-out infinite alternate;
}
```

The page has a subtle 3D tilt animation. There's also:
- Text shadows for depth
- CSS transforms for layering
- A proximity-based effect on the JSON output (text shadow appears as you mouse near it)

### Why It's Fast

Astro is really efficient:
- Zero JavaScript by default (we only added a small script for the hover effect)
- CSS is scoped and optimized
- The MySQL query runs server-side, so the client just gets HTML

You can strip out all the fancy CSS if you want something simpler - the MySQL connection will work the same.

---

## Troubleshooting

### "Cannot find module 'mysql2'"

Run `npm install` again. The dependencies might not have installed properly.

### "Access denied for user..."

Check your `.env` file. Make sure the credentials are correct and there are no extra spaces.

### Port 4321 already in use

Kill the other process or use a different port:
```bash
npm run dev -- --port 3000
```

### Changes not showing up

1. Make sure the dev server is running (`npm run dev`)
2. Check that you saved the file
3. Try a hard refresh (Cmd+Shift+R on Mac, Ctrl+Shift+R on Windows)

---

## Deploying to Classwork Server

There's a `deploy.sh` script for deploying to the OSU classwork server. You'll need:
- OSU VPN connected
- SSH access configured (ssh config alias: `classwork`)

```bash
./deploy.sh
```

But we can go over this together when we need to deploy - it's a bit involved.

---

## Questions?

Hit me up on Discord. This readme probably doesn't cover everything, and explaining things live is usually faster anyway.

---

## Useful Links

- **Astro Docs:** https://docs.astro.build/
- **Astro SSR Guide:** https://docs.astro.build/en/guides/on-demand-rendering/
- **mysql2 npm package:** https://www.npmjs.com/package/mysql2
- **Node.js Adapter:** https://docs.astro.build/en/guides/integrations-guide/node/
