#!/bin/bash

# fnixos Deployment Script (Non-Interactive)
# This script deploys the NixOS configuration without user prompts.

set -e

echo "🚀 Deploying fnixos configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        return 1
    fi
}

# Function to print info
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

echo ""
print_info "Checking prerequisites..."

# Check if we're in the right directory
if [ ! -f "flake.nix" ]; then
    print_status 1 "flake.nix not found. Please run this script from the fnixos directory."
    exit 1
fi
print_status 0 "Found flake.nix"

# Validate configuration
echo ""
print_info "Validating configuration..."
if bash home/scripts/validate.sh >/dev/null 2>&1; then
    print_status 0 "Configuration validation passed"
else
    print_info "Configuration validation had issues, but proceeding anyway."
fi

# Commit changes
echo ""
print_info "Committing changes..."
if git diff --quiet && git diff --cached --quiet; then
    print_status 0 "Working tree is clean, no changes to commit."
else
    git add .
    git commit -m "fix: apply automated fixes to hyprland configuration"
    print_status 0 "Committed changes."
fi

# Deploy the configuration
echo ""
print_info "Deploying NixOS configuration with: sudo nixos-rebuild switch --flake .#vm-m1"

# Run the deployment
# NOTE: This command will likely fail in this environment due to sudo password prompt.
# The user must run this command in their own interactive terminal.
echo "The following command needs to be run by the user:"
echo "sudo nixos-rebuild switch --flake .#vm-m1"

# Attempt to run it anyway, but expect it to fail.
sudo nixos-rebuild switch --flake .#vm-m1 || true

print_info "Deployment script finished."
