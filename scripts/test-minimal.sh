#!/bin/bash

# fnixos Minimal Test Script
# This script tests the minimal configuration without GNOME dependencies

set -e

echo "🧪 Testing minimal fnixos configuration..."

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
print_info "Testing flake check with experimental features..."

# Test flake check with experimental features
if nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Flake check passed - no GNOME dependencies!"
else
    print_status 1 "Flake check failed"
    echo "Run 'nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes' for details"
    exit 1
fi

echo ""
print_info "Testing dry build with experimental features..."

# Test dry build with experimental features
if sudo nixos-rebuild dry-build --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Dry build successful!"
    echo ""
    print_info "🎉 Configuration is now GNOME-free and ready for deployment!"
    print_info "You can now run:"
    echo "  • ./deploy.sh (recommended)"
    echo "  • sudo nixos-rebuild switch --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes"
else
    print_status 1 "Dry build failed!"
    echo ""
    print_info "Common solutions:"
    echo "  • Check the error messages above"
    echo "  • Run 'sudo nixos-rebuild dry-build --flake .#vm-m1 --show-trace' for detailed errors"
    exit 1
fi
