# fnixos - NixOS Configuration for ARM64 Apple Silicon

A minimal, performance-focused NixOS configuration optimized for VMware Fusion on ARM64 Apple Silicon with Hyprland window manager. Features a beautiful, modern interface with blur effects, rounded corners, and real-time system monitoring.

<p align="center">
  <img src="https://raw.githubusercontent.com/andev0x/description-image-archive/refs/heads/main/fnixos/p1.png"  />
</p>


## 🚀 Features

- **ARM64 Optimized**: Specifically configured for Apple Silicon
- **Pure Hyprland**: Lightweight Wayland compositor with beautiful animations
- **Modern Interface**: 
  - Waybar with blur effects and rounded corners
  - Real-time CPU and network speed monitoring
  - Application taskbar with icons
  - Bibata Modern Amber cursor theme
- **Dynamic Wallpapers**: Random wallpaper selection on startup and on-demand
- **Performance Focused**: Optimized kernel parameters and minimal resource usage
- **Developer Ready**: Comprehensive development tools and multiple browsers
- **Rofi Launcher**: Fast and beautiful application launcher
- **Nord Theme**: Consistent Nord color scheme throughout

## 📁 Project Structure

```
fnixos/
├── flake.nix                    # Main flake configuration
├── hosts/
│   └── vm-m1/                   # VM M1 host configuration
│       ├── configuration.nix    # Main system config
│       └── hardware-configuration.nix
├── modules/
│   ├── system/
│   │   └── base.nix            # Base system packages and settings
│   ├── desktop/
│   │   └── hyprland.nix        # Hyprland and theming
│   └── programs/
│       └── devtools.nix        # Development tools
├── home/
│   ├── default.nix             # Home Manager configuration
│   ├── waybar/                 # Status bar configuration
│   │   ├── config              # Waybar modules config
│   │   └── style.css           # Waybar styling
│   ├── hypr/
│   │   └── hyprland.conf       # Hyprland window manager config
│   └── wallpapers/             # Wallpaper directory
│       └── *.jpg/png           # Your wallpapers
└── scripts/
    ├── deploy.sh               # Deployment script
    ├── random-wallpaper.sh     # Random wallpaper switcher
    └── test-*.sh               # Testing scripts
```

## 🛠️ Installation

### Prerequisites
- VMware Fusion on Apple Silicon Mac
- NixOS ARM64 installed in VM
- Internet connection

### Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/andev0x/fnixos.git
   cd fnixos
   ```

2. **Deploy the system:**
   ```bash
   # Option 1: Use the deployment script (recommended)
   ./scripts/deploy.sh

   # Option 2: Test the configuration first
   ./scripts/test-build.sh

   # Option 3: Manual deployment
   sudo nixos-rebuild switch --flake .#vm-m1
   ```

3. **Update your email in home configuration:**
   Edit `home/default.nix` and update the git email:
   ```nix
   userEmail = "your-email@example.com";
   ```

4. **Reboot to apply all changes:**
   ```bash
   sudo reboot
   ```

## 🎨 Customization

### Wallpapers
- Add your wallpapers to `home/wallpapers/`
- Supported formats: JPG, JPEG, PNG, WEBP
- Press `ALT + W` to randomly change wallpaper
- Wallpapers change automatically on startup

### Waybar Customization
- **Config**: Edit `home/waybar/config` to add/remove modules
- **Styling**: Edit `home/waybar/style.css` to customize appearance
- Current modules:
  - Workspaces with window icons
  - Application taskbar
  - CPU usage monitor
  - Network speed (download/upload)
  - Audio volume
  - Battery status
  - System tray

### Key Bindings (Hyprland)

#### Window Management
- `ALT + Q`: Open terminal (Alacritty)
- `ALT + C`: Close window
- `ALT + R`: Application launcher (Rofi)
- `ALT + V`: Toggle floating window
- `ALT + M`: Exit Hyprland
- `ALT + P`: Pseudo tiling
- `ALT + J`: Toggle split

#### Navigation
- `ALT + 1-5`: Switch workspaces
- `ALT + SHIFT + 1-5`: Move window to workspace
- `ALT + Arrow Keys`: Move focus between windows
- `ALT + Mouse Down/Up`: Scroll through workspaces

#### Development Tools
- `ALT + T`: Open Neovim in terminal
- `ALT + B`: Open Qutebrowser
- `ALT + SHIFT + B`: Open Chromium
- `ALT + G`: Open LazyGit
- `ALT + F`: Open Ranger file manager
- `ALT + E`: Open Ranger

#### System
- `ALT + W`: Change wallpaper randomly
- `Print`: Screenshot selection (copy to clipboard)
- `ALT + Print`: Full screenshot (copy to clipboard)
- `XF86AudioRaiseVolume`: Increase volume
- `XF86AudioLowerVolume`: Decrease volume
- `XF86AudioMute`: Toggle mute
- `XF86MonBrightnessUp`: Increase brightness
- `XF86MonBrightnessDown`: Decrease brightness

#### Mouse Actions
- `ALT + Left Click + Drag`: Move window
- `ALT + Right Click + Drag`: Resize window

## 🔧 Development Tools

Pre-installed development tools:

### Editors & IDEs
- **Neovim**: Modern modal editor (default)
- **VS Code**: Full-featured IDE
- **Helix**: Modern modal editor

### Programming Languages
- **Go**: System programming
- **Rust**: Safe system programming
- **Python**: Scripting and development
- **Node.js**: JavaScript runtime
- **Deno**: Secure JavaScript/TypeScript runtime

### Build Tools
- GCC, Clang
- CMake, Make, Ninja
- Cargo (Rust)
- npm, yarn (Node.js)

### Git Tools
- **LazyGit**: Terminal UI for git
- **Delta**: Beautiful git diff viewer
- **Gitui**: Blazing fast terminal UI

### File Management
- **Ranger**: Terminal file manager with preview
- **LF**: Fast terminal file manager
- **FZF**: Fuzzy finder

### Terminal & Shell
- **Alacritty**: GPU-accelerated terminal
- **Tmux**: Terminal multiplexer
- **Zsh**: Modern shell with Oh My Zsh
- **Starship**: Fast, customizable prompt

### Web Browsers
- **Qutebrowser**: Keyboard-focused browser (default)
- **Firefox**: Full-featured browser
- **Chromium**: Google's open-source browser
- **Brave**: Privacy-focused browser

### Utilities
- **ripgrep**: Fast text search
- **fd**: Fast find alternative
- **bat**: Cat clone with syntax highlighting
- **exa**: Modern ls replacement
- **tree**: Directory tree viewer
- **htop**: Interactive process viewer

## 📊 System Monitoring

The waybar displays real-time system information:

- **CPU Usage**: Real-time CPU percentage with 2s refresh
- **Network Speed**: 
  - Download speed (⬇)
  - Upload speed (⬆)
  - Signal strength for Wi-Fi
- **Battery**: Percentage and charging status
- **Audio**: Volume level and mute status

## 📋 System Requirements

- **Architecture**: ARM64 (aarch64-linux)
- **Platform**: VMware Fusion on Apple Silicon
- **Memory**: Minimum 4GB RAM (8GB recommended)
- **Storage**: Minimum 20GB free space
- **VM Settings**:
  - Enable 3D acceleration
  - Allocate 2+ CPU cores
  - Enable shared folders (optional)

## 🔄 Updates

### Update System Packages
```bash
cd fnixos
sudo nixos-rebuild switch --flake .#vm-m1 --upgrade
```

### Update Flake Inputs
```bash
nix flake update
sudo nixos-rebuild switch --flake .#vm-m1
```

### Pull Latest Configuration
```bash
git pull origin main
sudo nixos-rebuild switch --flake .#vm-m1
```

## 🐛 Troubleshooting

### Common Issues

1. **Rofi doesn't open applications**
   - Make sure you have `rofi-wayland` installed
   - Check if applications are in your PATH
   - Try running `rofi -show drun -show-icons` manually

2. **Wallpaper not changing**
   - Verify wallpapers exist in `home/wallpapers/`
   - Check script path: `~/Documents/fnixos/scripts/random-wallpaper.sh`
   - Run manually: `bash ~/Documents/fnixos/scripts/random-wallpaper.sh`

3. **Waybar not showing blur effect**
   - Ensure Hyprland blur is enabled in `hyprland.conf`
   - Check layer rules: `layerrule = blur, waybar`
   - Restart waybar: `killall waybar && waybar &`

4. **Build fails**
   - Check for syntax errors: `nix flake check`
   - View detailed errors: `sudo nixos-rebuild switch --flake .#vm-m1 --show-trace`
   - Clear build cache: `nix-collect-garbage -d`

5. **Display issues**
   - Ensure VMware guest tools are enabled
   - Check virtualization settings in configuration
   - Verify `virtualisation.vmware.guest.enable = true`

6. **Audio not working**
   - Check PipeWire status: `systemctl --user status pipewire`
   - Restart audio: `systemctl --user restart pipewire`
   - Use `pavucontrol` for audio settings

### Logs and Debugging

```bash
# System logs
journalctl -xe
journalctl -u display-manager

# Home Manager logs
home-manager generations
home-manager logs

# Check Hyprland logs
cat ~/.local/share/hyprland/hyprland.log

# Test configuration without switching
sudo nixos-rebuild test --flake .#vm-m1
```

## 🎯 Performance Tips

1. **Disable animations** (if needed):
   Edit `home/hypr/hyprland.conf`:
   ```conf
   animations {
       enabled = no
   }
   ```

2. **Reduce waybar update frequency**:
   Edit `home/waybar/config` and increase `interval` values

3. **Limit background applications**:
   Check `exec-once` lines in `hyprland.conf`

4. **Use software rendering** (if GPU issues):
   Applications already use `LIBGL_ALWAYS_SOFTWARE=1` flag

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Here's how:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes
4. Test the configuration: `./scripts/test-build.sh`
5. Commit changes: `git commit -am 'Add feature'`
6. Push to branch: `git push origin feature-name`
7. Submit a pull request

### Contribution Guidelines
- Follow the existing code style
- Test configurations before submitting
- Document new features in README
- Keep commits atomic and well-described

## 🙏 Acknowledgments

- [NixOS](https://nixos.org/) - The purely functional Linux distribution
- [Hyprland](https://hyprland.org/) - Dynamic tiling Wayland compositor
- [Waybar](https://github.com/Alexays/Waybar) - Highly customizable status bar
- [Rofi](https://github.com/lbonn/rofi) - Application launcher
- [Nord Theme](https://www.nordtheme.com/) - Arctic, north-bluish color scheme
- [Bibata Cursor](https://github.com/ful1e5/Bibata_Cursor) - Modern cursor theme

## 📧 Contact

- GitHub: [@andev0x](https://github.com/andev0x)
- Issues: [GitHub Issues](https://github.com/andev0x/fnixos/issues)

---

**Made with ❤️ for the NixOS community**
