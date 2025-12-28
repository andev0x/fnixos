# fnixos - NixOS Configuration for ARM64 Apple Silicon

A highly optimized NixOS configuration for VMware Fusion on ARM64 Apple Silicon with Hyprland window manager. Features comprehensive Wi-Fi support, Banana cursor theme, automatic wallpaper management, and professional development tools.

<p align="center">
  <img src="https://raw.githubusercontent.com/andev0x/description-image-archive/refs/heads/main/fnixos/p1.png"  />
</p>

## Features

- **ARM64 Optimized**: Specifically tuned for Apple Silicon processors
- **Pure Hyprland**: Lightweight Wayland compositor with smooth animations
- **Full Wi-Fi Support**: NetworkManager with iwd backend and nm-applet
- **Banana Cursor Theme**: Beautiful cursor theme with proper GTK integration
- **Smart Wallpapers**: Automatic wallpaper rotation with notifications
- **Performance Focused**: Optimized kernel parameters and minimal bloat
- **Developer Ready**: Complete development environment with modern tools
- **Professional Shortcuts**: Intuitive keybindings for maximum productivity

## Project Structure

```
fnixos/
├── flake.nix                          # Main flake with ARM64 optimizations
├── hosts/vm-m1/
│   ├── configuration.nix              # System configuration
│   └── hardware-configuration.nix     # Hardware & VM optimization
├── modules/
│   ├── system/base.nix                # Base system with Wi-Fi support
│   ├── desktop/hyprland.nix           # Hyprland with Banana cursor
│   └── programs/devtools.nix          # Development tools
└── home/
    ├── default.nix                    # Home Manager with cursor config
    ├── hypr/hyprland.conf             # Hyprland keybindings
    ├── waybar/config                  # Status bar configuration
    ├── scripts/
    │   ├── random-wall.sh             # Smart wallpaper management
    │   └── toggle-theme.sh            # Theme switching
    └── wallpapers/                    # Your wallpaper collection
```

## Installation

### 1. Clone Repository
```bash
git clone https://github.com/andev0x/fnixos.git /etc/nixos
cd /etc/nixos
```

### 2. Update Configuration
Edit `home/default.nix` and update your information:
```nix
home.username = "your-username";
programs.git.userName = "your-name";
programs.git.userEmail = "your-email@example.com";
```

### 3. Deploy System
```bash
# Recommended: Use deployment script
sudo ./deploy.sh

# Or manually
sudo nixos-rebuild switch --flake .#vm-m1
```

### 4. Post-Installation
```bash
# Reboot to apply all changes
sudo reboot

# After reboot, check Wi-Fi status
nmcli device status
nmcli device wifi list
```

## Key Features

### Wi-Fi Management
- **NetworkManager**: Full Wi-Fi support with iwd backend
- **nm-applet**: System tray indicator for easy network management
- **nmtui**: Terminal UI for network configuration
- **Shortcuts**: 
  - `Super + Click Network Icon`: Open network settings
  - Terminal: `nmtui` for text interface

### Banana Cursor Theme
- Automatically installed and configured
- Works in Wayland and GTK applications
- Size: 24px (configurable in home/default.nix)
- Environment variables properly set system-wide

### Smart Wallpaper System
```bash
# Scripts automatically cycle wallpapers
~/.config/scripts/random-wall.sh next      # Next wallpaper
~/.config/scripts/random-wall.sh prev      # Previous wallpaper
~/.config/scripts/random-wall.sh random    # Random wallpaper
~/.config/scripts/random-wall.sh default   # Default (shisui.png)

# Wallpapers stored in:
~/.local/share/wallpapers/
```

### Waybar Status Bar
- **Left**: Workspaces, Active window
- **Center**: Clock with date
- **Right**: CPU, Memory, Audio, Network, System tray
- **Features**: Click modules to open relevant apps
- **Network**: Shows Wi-Fi signal strength and SSID

## Keybindings

### Essential
| Shortcut | Action |
|----------|--------|
| `Super + Return` / `Super + Q` | Terminal (Alacritty) |
| `Super + Space` / `Super + R` | Application launcher |
| `Super + B` | Browser (Qutebrowser) |
| `Super + E` | File manager (Ranger) |
| `Super + C` | Close window |
| `Super + M` | Exit Hyprland |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |

### Window Navigation
| Shortcut | Action |
|----------|--------|
| `Super + Arrow Keys` | Move focus |
| `Super + H/J/K/L` | Move focus (Vim style) |
| `Super + Shift + Arrow Keys` | Move window |
| `Super + Ctrl + Arrow Keys` | Resize window |

### Workspaces
| Shortcut | Action |
|----------|--------|
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Tab` | Next workspace |
| `Super + Shift + Tab` | Previous workspace |
| `Super + S` | Toggle special workspace |

### Wallpaper Control
| Shortcut | Action |
|----------|--------|
| `Super + W` | Next wallpaper |
| `Super + Shift + W` | Random wallpaper |
| `Super + Ctrl + W` | Previous wallpaper |

### Multimedia
| Shortcut | Action |
|----------|--------|
| `Volume Up/Down` | Adjust volume |
| `Volume Mute` | Toggle mute |
| `Brightness Up/Down` | Adjust brightness |
| `Print` | Screenshot area |
| `Super + Print` | Screenshot full screen |

### Development
| Shortcut | Action |
|----------|--------|
| `Super + G` | LazyGit |
| `Super + T` | Toggle theme |

## Development Tools

### Pre-installed
- **Languages**: Go, Rust, Python, Node.js
- **Build Tools**: GCC, Make, CMake
- **Editors**: Neovim (default)
- **Git Tools**: LazyGit, Delta, GitUI
- **File Tools**: Ranger, FZF, Bat, Eza
- **Terminals**: Alacritty, Kitty
- **Shell**: Zsh with Oh-My-Zsh, Starship prompt

### Useful Aliases
```bash
ll          # eza -la --icons
vim         # nvim
cat         # bat
grep        # rg
find        # fd
rebuild     # Rebuild NixOS configuration
update      # Update flake and rebuild
clean       # Garbage collect and optimize
generations # List system generations
```

## System Requirements

- **Architecture**: ARM64 (aarch64-linux)
- **Platform**: VMware Fusion on Apple Silicon (M1/M2/M3)
- **RAM**: Minimum 4GB (8GB recommended)
- **Storage**: 20GB minimum (40GB recommended)
- **Network**: Wi-Fi adapter supported by Linux kernel

## Customization

### Change Wallpapers
1. Add images to `~/.local/share/wallpapers/`
2. Wallpapers auto-rotate on startup
3. Use keybindings to cycle through them

### Change Cursor Size
Edit `home/default.nix`:
```nix
home.pointerCursor = {
  name = "Banana";
  size = 32;  # Change this value
  package = pkgs.banana-cursor;
};
```

### Change Theme Colors
Edit `home/waybar/style-dark.css` and `home/waybar/style-light.css`
Toggle between themes: `Super + T`

### Modify Keybindings
Edit `home/hypr/hyprland.conf` and customize the bindings

## Troubleshooting

### Wi-Fi Not Working
```bash
# Check NetworkManager status
systemctl status NetworkManager

# List available networks
nmcli device wifi list

# Connect to network
nmcli device wifi connect "SSID" password "password"

# Open network manager applet
nm-applet &
```

### Cursor Not Showing
```bash
# Check cursor environment
echo $XCURSOR_THEME  # Should be "Banana"
echo $XCURSOR_SIZE   # Should be "24"

# Restart Hyprland
Super + M (exit) then login again
```

### Wallpaper Not Loading
```bash
# Check wallpaper directory
ls ~/.local/share/wallpapers/

# Check script logs
cat ~/.cache/random-wall.log

# Manually set wallpaper
~/.config/scripts/random-wall.sh default
```

### Waybar Not Starting
```bash
# Check waybar logs
journalctl --user -u waybar

# Restart waybar
pkill waybar && waybar &
```

## Performance Optimizations

### Applied Optimizations
- **Kernel**: mitigations=off, preempt=full, transparent_hugepage
- **Memory**: vm.swappiness=10, zram compression
- **Filesystem**: noatime, nodiratime, discard
- **Nix**: Binary cache, parallel builds, auto-optimize
- **Graphics**: Mesa drivers, Vulkan support
- **Audio**: Low-latency PipeWire configuration
- **VMware**: Guest tools, optimized modules

## Updates

### Update System
```bash
cd /etc/nixos
sudo nix flake update
sudo nixos-rebuild switch --flake .#vm-m1
```

### Update Specific Input
```bash
sudo nix flake lock --update-input nixpkgs
sudo nixos-rebuild switch --flake .#vm-m1
```

## License

MIT License - see LICENSE file for details

## Acknowledgments

- [NixOS](https://nixos.org/) - The purely functional Linux distribution
- [Hyprland](https://hyprland.org/) - Dynamic tiling Wayland compositor
- [Waybar](https://github.com/Alexays/Waybar) - Highly customizable status bar
- [Banana Cursor](https://github.com/ful1e5/Banana-cursor) - Beautiful cursor theme
- Community contributors and testers

---

**Author**: anvndev  
**Repository**: https://github.com/andev0x/fnixos  
**Issues**: https://github.com/andev0x/fnixos/issues

