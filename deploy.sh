#!/bin/bash
# Deploy script for CS340 Astro project
# Run this while connected to OSU VPN

set -e

echo "🚀 Deploying to classwork server..."

# Sync files (excluding node_modules, dist, .git, .env)
rsync -avz --delete \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='.git' \
  --exclude='.env' \
  --exclude='.DS_Store' \
  --exclude='deploy.sh' \
  ./ classwork:~/CS340/activity2/

echo "📦 Installing dependencies and building..."

# SSH in and rebuild
ssh classwork << 'ENDSSH'
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

  cd ~/CS340/activity2

  # Stop existing server
  npx forever stop dist/server/entry.mjs 2>/dev/null || true

  # Install dependencies and build
  npm install
  npm run build

  # Start server
  HOST=0.0.0.0 PORT=8742 npx forever start dist/server/entry.mjs

  echo "✅ Server running at http://classwork.engr.oregonstate.edu:8742/"
ENDSSH

echo "🎉 Deploy complete!"
