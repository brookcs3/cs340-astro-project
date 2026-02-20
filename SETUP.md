# CS340 Project Setup Guide (Windows 10)

## Prerequisites

### 1. Install Node.js
1. Go to [https://nodejs.org](https://nodejs.org)
2. Download the **LTS** version (should be 20.x or newer)
3. Run the installer — accept all defaults
4. Verify installation by opening **Command Prompt** or **PowerShell**:
   ```
   node --version
   npm --version
   ```
   Both should print version numbers.

### 2. Install Git
1. Go to [https://git-scm.com/download/win](https://git-scm.com/download/win)
2. Download and run the installer — accept all defaults
3. Verify:
   ```
   git --version
   ```

### 3. Connect to OSU VPN
The database server (`classmysql.engr.oregonstate.edu`) is only accessible from the OSU network.

1. Install **Cisco AnyConnect** if you don't have it already
   - Download from [https://oregonstate.teamdynamix.com/TDClient/1935/Portal/KB/ArticleDet?ID=76790](https://oregonstate.teamdynamix.com/TDClient/1935/Portal/KB/ArticleDet?ID=76790)
2. Connect to `vpn.oregonstate.edu`
3. Sign in with your ONID credentials
4. You **must be connected to the VPN** any time you run the app locally

---

## Clone and Run the Project

### 1. Clone the Repository
Open **Command Prompt**, **PowerShell**, or **Git Bash**:
```bash
git clone https://github.com/brookcs3/cs340-astro-project.git
cd cs340-astro-project
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Create the Environment File
Create a file named `.env` in the project root with this content:
```
MYSQL_HOST=classmysql.engr.oregonstate.edu
MYSQL_USER=cs340_brooksc3
MYSQL_PASSWORD=3434
MYSQL_DATABASE=cs340_brooksc3
```

> **Note:** The `.env` file is gitignored so it won't appear after cloning. You have to create it manually.

### 4. Start the Dev Server
Make sure you're connected to the OSU VPN, then:
```bash
npm run dev
```

You should see output like:
```
astro  v5.x.x ready in XXXms

┃ Local    http://localhost:8742/
┃ Network  http://0.0.0.0:8742/
```

### 5. Open in Browser
Go to [http://localhost:8742](http://localhost:8742) in your browser.

---

## Project Pages

| Page | URL | Operations |
|------|-----|------------|
| Home | `/` | Overview & navigation |
| Players | `/players` | Browse, Add, Update, Delete |
| Games | `/games` | Browse, Add, Update, Delete |
| Platforms | `/platforms` | Browse, Add, Update, Delete |
| Run Categories | `/run-categories` | Browse, Add, Update, Delete |
| Run Submissions | `/run-submissions` | Browse, Add, Update, Delete |
| Games on Platforms | `/games-on-platforms` | Browse, Add, Delete |

---

## Pulling Updates

When new changes are pushed to the repo:
```bash
git pull origin main
npm install
```

Then restart the dev server (`npm run dev`).

---

## Deploying to the ENGR Classwork Server

This is how the app was deployed to `http://classwork.engr.oregonstate.edu:8742`. Use these steps to redeploy after changes.

### 1. SSH into classwork
```bash
ssh classwork
# (shortcut for: ssh brooksc3@classwork.engr.oregonstate.edu)
```

### 2. Navigate to the project
```bash
cd ~/CS340/project
```

### 3. Pull latest changes
```bash
export PATH=~/.nvm/versions/node/v18.20.8/bin:$PATH
git pull origin main
npm install
```

### 4. Rebuild the Astro app
```bash
npm run build
```

### 5. Restart the server with `forever`
```bash
# Stop the old process
npx forever stopall

# Start the new build
npx forever start start.cjs
```

### 6. Verify it's running
```bash
npx forever list
curl -s -o /dev/null -w '%{http_code}' http://localhost:8742/
# Should print: 200
```

### How it works
- `start.cjs` is a Node wrapper that sets the environment variables (DB credentials, host, port) and then imports the built Astro server (`dist/server/entry.mjs`)
- `forever` keeps the process alive in the background even after you disconnect from SSH
- The server listens on `0.0.0.0:8742` so it's accessible at `http://classwork.engr.oregonstate.edu:8742`
- The classwork server can reach `classmysql.engr.oregonstate.edu` directly (no VPN needed server-side)

### Key files on the server
```
~/CS340/project/          # Git clone of the repo
~/CS340/project/.env      # DB credentials (not in git)
~/CS340/project/start.cjs # Node wrapper with env vars
~/CS340/project/dist/     # Built Astro output (from npm run build)
~/CS340/activity2/        # Old Activity 2 project (no longer running)
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `getaddrinfo ENOTFOUND classmysql.engr.oregonstate.edu` | You're not connected to the OSU VPN. Connect via Cisco AnyConnect first. |
| `npm run dev` fails with module errors | Run `npm install` again. |
| Port 8742 already in use | Kill the other process or change the port in `astro.config.mjs`. |
| Database errors on page load | Check that `.env` exists and credentials are correct. |
| `node --version` not recognized | Reinstall Node.js and make sure "Add to PATH" is checked during install. |
