#!/bin/bash

# fnixos Deployment Script
# This script helps deploy the NixOS configuration

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

# Function to print warning
print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo ""
print_info "Checking prerequisites..."

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_warning "Running as root. Make sure this is what you want."
else
    print_info "Not running as root. You may need to use sudo."
fi

# Check if we're in the right directory
if [ ! -f "flake.nix" ]; then
    print_status 1 "flake.nix not found. Please run this script from the fnixos directory."
    exit 1
fi

print_status 0 "Found flake.nix"

# Validate configuration
echo ""
print_info "Validating configuration..."
if bash validate.sh >/dev/null 2>&1; then
    print_status 0 "Configuration validation passed"
else
    print_warning "Configuration validation had issues. Check the output above."
    echo "Continue anyway? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled."
        exit 1
    fi
fi

# Check git status
echo ""
print_info "Checking git status..."
if git diff --quiet && git diff --cached --quiet; then
    print_status 0 "Working tree is clean"
else
    print_warning "Working tree has uncommitted changes"
    echo "Current changes:"
    git status --short
    echo ""
    echo "Commit changes before deployment? (y/N)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Enter commit message (or press Enter for default):"
        read -r commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Update configuration"
        fi
        git add .
        git commit -m "$commit_msg"
        print_status 0 "Changes committed"
    fi
fi

# Deploy the configuration
echo ""
print_info "Deploying NixOS configuration..."
echo "This will run: sudo nixos-rebuild switch --flake .#vm-m1"

# Ask for confirmation
echo "Proceed with deployment? (y/N)"
read -r response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

# Run the deployment
if sudo nixos-rebuild switch --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes; then
    echo ""
    print_status 0 "Deployment successful!"
    echo ""
    print_info "Your NixOS system has been updated with the fnixos configuration."
    print_info "You can now:"
    echo "  • Log out and log back in to start using Hyprland"
    echo "  • Use Super+Q to open a terminal"
    echo "  • Use Super+R to open the application launcher"
    echo "  • Customize your wallpaper in ~/.config/wallpapers/"
else
    print_status 1 "Deployment failed!"
    echo ""
    print_info "Common solutions:"
    echo "  • Check the error messages above"
    echo "  • Run 'sudo nixos-rebuild switch --flake .#vm-m1 --show-trace' for detailed errors"
    echo "  • Make sure all configuration files are syntactically correct"
    exit 1
fi
