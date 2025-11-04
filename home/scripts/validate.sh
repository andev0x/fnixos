#!/bin/bash

# fnixos Configuration Validation Script
# This script validates the NixOS configuration for common issues

set -e

echo "🔍 Validating fnixos configuration..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo "📋 Checking file structure..."

# Check if required files exist
required_files=(
    "flake.nix"
    "hosts/vm-m1/configuration.nix"
    "hosts/vm-m1/hardware-configuration.nix"
    "modules/system/base.nix"
    "modules/desktop/hyprland.nix"
    "modules/programs/devtools.nix"
    "home/default.nix"
    "home/waybar/config"
    "home/waybar/style.css"
    "home/hypr/hyprland.conf"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        print_status 0 "Found $file"
    else
        print_status 1 "Missing $file"
        exit 1
    fi
done

echo ""
echo "🔧 Checking configuration syntax..."

# Check Nix syntax if nix is available
if command -v nix >/dev/null 2>&1; then
    if nix flake check . >/dev/null 2>&1; then
        print_status 0 "Nix flake syntax is valid"
    else
        print_status 1 "Nix flake syntax errors found"
        echo "Run 'nix flake check' for details"
    fi
else
    print_warning "Nix not found - skipping syntax validation"
fi

echo ""
echo "🏗️  Checking ARM64 compatibility..."

# Check for ARM64 system specification
if grep -q 'system = "aarch64-linux"' flake.nix; then
    print_status 0 "ARM64 system architecture specified"
else
    print_status 1 "ARM64 system architecture not found"
fi

echo ""
echo "🎨 Checking theming configuration..."

# Check that Waybar style exists and hypr config is present
if [ -f "home/waybar/style.css" ] || [ -f "home/waybar/style-dark.css" ]; then
    print_status 0 "Waybar style found"
else
    print_warning "Waybar style not found"
fi

if grep -q "hyprland" modules/desktop/hyprland.nix; then
    print_status 0 "Hyprland theming configured"
else
    print_warning "Hyprland theming not explicitly configured"
fi

echo ""
echo "🖥️  Checking desktop environment..."

# Check for Hyprland
if grep -q "hyprland" modules/desktop/hyprland.nix; then
    print_status 0 "Hyprland window manager configured"
else
    print_status 1 "Hyprland not configured"
fi

# Check for Waybar
if grep -q "waybar" modules/desktop/hyprland.nix; then
    print_status 0 "Waybar status bar configured"
else
    print_status 1 "Waybar not configured"
fi

echo ""
echo "🛠️  Checking development tools..."

# Check for essential dev tools
dev_tools=("neovim" "git" "gcc" "go" "rustup")
for tool in "${dev_tools[@]}"; do
    if grep -q "$tool" modules/programs/devtools.nix; then
        print_status 0 "$tool configured"
    else
        print_warning "$tool not found in devtools"
    fi
done

echo ""
echo "🏠 Checking home configuration..."

# Check for proper home manager setup
if grep -q "home-manager" hosts/vm-m1/configuration.nix; then
    print_status 0 "Home Manager integration configured"
else
    print_status 1 "Home Manager not configured"
fi

# Check for git email configuration
if grep -q "userEmail.*example.com" home/default.nix; then
    print_warning "Git email still set to example.com - please update"
else
    print_status 0 "Git email configured"
fi

echo ""
echo "📱 Checking wallpaper support..."

# Check for wallpaper configuration
if [ -d "home/wallpapers" ]; then
    print_status 0 "Wallpaper directory exists"
else
    print_status 1 "Wallpaper directory missing"
fi

if grep -q "swww" home/hypr/hyprland.conf; then
    print_status 0 "Wallpaper daemon (swww) configured"
else
    print_status 1 "Wallpaper daemon not configured"
fi

echo ""
echo "🔒 Checking security configuration..."

# Check for sudo configuration
if grep -q "wheelNeedsPassword = false" modules/system/base.nix; then
    print_warning "Sudo password disabled for wheel group (development mode)"
else
    print_status 0 "Sudo password required"
fi

echo ""
echo "📊 Validation Summary:"
echo "Configuration appears to be properly structured for ARM64 M1 MacBook"
echo "Ready for deployment with 'sudo nixos-rebuild switch --flake .#vm-m1'"
echo ""
echo "⚠️  Don't forget to:"
echo "  1. Update git email in home/default.nix"
echo "  2. Add your preferred wallpaper to home/wallpapers/"
echo "  3. Customize key bindings in home/hypr/hyprland.conf if needed"
