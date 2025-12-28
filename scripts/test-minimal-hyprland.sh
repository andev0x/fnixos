#!/bin/bash

# fnixos Minimal Hyprland Test Script
# This script tests the minimal Hyprland-only configuration

set -e

echo "🧪 Testing minimal Hyprland-only configuration..."

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
print_info "Testing minimal flake check..."

# Test flake check
if nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Flake check passed - minimal configuration!"
else
    print_status 1 "Flake check failed"
    echo "Run 'nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes' for details"
    exit 1
fi

echo ""
print_info "Testing minimal dry build..."

# Test dry build
if sudo nixos-rebuild dry-build --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Dry build successful!"
    echo ""
    print_info "🎉 Minimal Hyprland configuration is ready!"
    print_info "Configuration includes:"
    echo "  ✅ Pure Hyprland window manager"
    echo "  ✅ No GNOME dependencies"
    echo "  ✅ Minimal package set"
    echo "  ✅ Essential development tools"
    echo "  ✅ Firefox and Chromium browsers"
    echo "  ✅ Simple Waybar status bar"
    echo ""
    print_info "You can now deploy with:"
    echo "  • ./deploy.sh"
    echo "  • sudo nixos-rebuild switch --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes"
else
    print_status 1 "Dry build failed!"
    echo ""
    print_info "Run for details:"
    echo "  • sudo nixos-rebuild dry-build --flake .#vm-m1 --show-trace --extra-experimental-features nix-command --extra-experimental-features flakes"
    exit 1
fi
