#!/bin/bash
set -e

echo "========================================="
echo "Neovim Offline Installation Test"
echo "========================================="
echo ""

# Build and start the container
echo "[1/5] Building Docker container..."
docker-compose build --no-cache

echo ""
echo "[2/5] Starting container..."
docker-compose up -d

echo ""
echo "[3/5] Running offline installation script..."
docker-compose exec nvim-test bash -c "cd /opt/nvim-offline/scripts && sudo ./install-offline.sh"

echo ""
echo "[4/5] Running verification script..."
docker-compose exec nvim-test bash -c "/opt/nvim-offline/scripts/verify.sh"

echo ""
echo "[5/5] Running Neovim health check..."
docker-compose exec nvim-test nvim --headless "+checkhealth" "+qa"

echo ""
echo "========================================="
echo "✅ Installation test completed!"
echo "========================================="
echo ""
echo "To manually test Neovim in the container:"
echo "  docker-compose exec nvim-test bash"
echo "  nvim test.py"
echo ""
echo "To stop the container:"
echo "  docker-compose down"
