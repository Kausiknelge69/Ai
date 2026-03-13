#!/bin/bash
set -e

echo "🚀 Installing Ollama + OpenClaw + dependencies..."

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &  # background
sleep 5

# Pull your model (qwen3.5:9b — if not exact name, use closest like qwen2.5:7b or qwen2.5-coder:7b)
ollama pull qwen2.5:7b   # ← change to exact tag if you have one; 9B works great

# Install OpenClaw (Node)
npm install -g openclaw@latest

# Setup Docker sandboxed OpenClaw (this is your ClawGuard security layer!)
export OPENCLAW_SANDBOX=1
export OPENCLAW_DOCKER_SOCKET=/var/run/docker.sock
git clone https://github.com/openclaw/openclaw.git /tmp/openclaw || true
cd /tmp/openclaw
./docker-setup.sh

echo "✅ OpenClaw gateway running at http://localhost:18789"
echo "✅ Ollama at http://localhost:11434"
echo "✅ Docker sandbox enabled — agents are isolated!"

# Python controller deps
pip install python-telegram-bot requests