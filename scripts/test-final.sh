#!/bin/bash

# fnixos Final Test Script
# This script tests the complete configuration with all fixes applied

set -e

echo "🧪 Testing final fnixos configuration with all fixes..."

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

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo ""
print_info "Step 1: Testing flake check with experimental features..."

# Test flake check with experimental features
if nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Flake check passed - Stylix and all modules configured correctly!"
else
    print_status 1 "Flake check failed"
    echo "Run 'nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes' for details"
    exit 1
fi

echo ""
print_info "Step 2: Testing dry build with experimental features..."

# Test dry build with experimental features
if sudo nixos-rebuild dry-build --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes; then
    print_status 0 "Dry build successful!"
    echo ""
    print_info "🎉 Configuration is now completely fixed and ready for deployment!"
    print_info "All issues resolved:"
    echo "  ✅ Stylix configuration fixed"
    echo "  ✅ Missing packages resolved"
    echo "  ✅ Hyprland configuration corrected"
    echo "  ✅ Development tools properly configured"
    echo ""
    print_info "You can now deploy with:"
    echo "  • ./deploy.sh (recommended)"
    echo "  • sudo nixos-rebuild switch --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes"
else
    print_status 1 "Dry build failed!"
    echo ""
    print_info "If there are still errors, run:"
    echo "  • sudo nixos-rebuild dry-build --flake .#vm-m1 --show-trace --extra-experimental-features nix-command --extra-experimental-features flakes"
    echo "  • Check the specific error messages above"
    exit 1
fi

echo ""
print_info "Step 3: Configuration summary..."
echo "📋 Your fnixos configuration now includes:"
echo "  • Pure Hyprland window manager (no GNOME dependencies)"
echo "  • Stylix theming with Nord theme"
echo "  • Multiple browsers: Firefox, Chromium, Brave"
echo "  • Development tools: Neovim, VS Code, Helix"
echo "  • Git tools: LazyGit, Delta, Gitui"
echo "  • File managers: Ranger, LF"
echo "  • Terminal: Kitty, Tmux, Zsh with Starship"
echo "  • Performance optimizations for ARM64 M1"
echo ""
print_info "Ready for development and web browsing! 🚀"
