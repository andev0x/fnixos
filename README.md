# fnixos - NixOS Configuration for ARM64 Apple Silicon

A minimal, performance-focused NixOS configuration optimized for VMware Fusion on ARM64 Apple Silicon with Hyprland window manager. Perfect for developers who prioritize speed, efficiency, and web browsing.

<p align="center">
  <img src="https://raw.githubusercontent.com/andev0x/description-image-archive/refs/heads/main/fnixos/p1.png"  />
</p>


## 🚀 Features

- **ARM64 Optimized**: Specifically configured for Apple Silicon
- **Pure Hyprland**: No GNOME dependencies - lightweight Wayland compositor
- **Performance Focused**: Optimized kernel parameters and minimal resource usage
- **Developer Ready**: Comprehensive development tools and multiple browsers
- **Web Browsing**: Qute, Firefox, Chromium, and Brave pre-installed
- **Minimal & Fast**: Clean, logical configuration with performance optimizations
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
└── home/
    ├── default.nix             # Home Manager configuration
    ├── waybar/                 # Status bar configuration
    │   ├── config
    │   └── style.css
    ├── hypr/
    │   └── hyprland.conf       # Hyprland window manager config
    └── wallpapers/             # Wallpaper directory
        └── README.md
```

## 🛠️ Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/andev0x/fnixos.git
   cd fnixos
   ```

2. **Deploy the system:**
   ```bash
   # Option 1: Use the deployment script (recommended)
   ./deploy.sh

   # Option 2: Test the configuration first
   ./test-build.sh

   # Option 3: Manual deployment
   sudo nixos-rebuild switch --flake .#vm-m1 --extra-experimental-features nix-command --extra-experimental-features flakes
   ```

3. **Update your email in home configuration:**
   Edit `home/default.nix` and update the git email:
   ```nix
   userEmail = "andev@example.com";
   ```

## 🎨 Customization

### Wallpapers
- Place your wallpapers in `home/wallpapers/`
- Update `home/hypr/hyprland.conf` to use your wallpaper:
  ```nix
  exec-once = swww img ~/Pictures/wallpapers/your-wallpaper.jpg
  ```

### Themes
- The system uses Stylix for consistent theming
- Nord color scheme is applied throughout
- Fonts: JetBrainsMono Nerd Font

### Key Bindings (Hyprland)
- `Super + Q`: Open terminal (Kitty)
- `Super + C`: Close window
- `Super + R`: Application launcher (Wofi)
- `Super + V`: Toggle floating window
- `Super + 1-5`: Switch workspaces
- `Print`: Screenshot

### Development Key Bindings
- `Super + T`: Open Neovim in terminal
- `Super + B`: Open Firefox (Browser)
- `Super + Shift + B`: Open Chromium
- `Super + G`: Open LazyGit
- `Super + F`: Open Ranger file manager
- `Super + E`: Open Ranger file manager

## 🔧 Development Tools

Pre-installed development tools:
- **Editors**: Neovim (default), VS Code, Helix
- **Languages**: Go, Rust, Python, Node.js, Deno
- **Build Tools**: GCC, CMake, Make, Ninja
- **Git Tools**: LazyGit, Delta, Gitui
- **File Management**: Ranger, LF, FZF
- **Terminal**: Kitty, Tmux, Zsh with Oh My Zsh
- **Shell**: Starship prompt, useful aliases
- **Browsers**: Firefox, Chromium, Brave, Qute
- **Utilities**: ripgrep, fd, bat, exa, tree

## 📋 System Requirements

- **Architecture**: ARM64 (aarch64-linux)
- **Platform**: VMware Fusion on Apple Silicon
- **Memory**: Minimum 4GB RAM
- **Storage**: Minimum 20GB free space

## 🔄 Updates

To update your system:
```bash
cd fnixos
git pull
sudo nixos-rebuild switch --flake .#vm-m1 --upgrade
```

## 🧪 DevShells for Development

Go-focused DevShell is available via flakes:

```bash
# Enter default dev shell (basic tools)
nix develop

# Enter Go dev shell with gopls, golangci-lint, and gotools
nix develop .#go

# Inside the shell
go version
golangci-lint version
gopls version
```

## 🐛 Troubleshooting

### Common Issues

1. **Build fails**: Check Nix version compatibility
2. **Display issues**: Ensure VMware tools are properly installed
3. **Audio not working**: Verify PipeWire is running

### Logs
```bash
# System logs
journalctl -u hyprland
journalctl -u waybar

# Home Manager logs
home-manager logs
```

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the configuration
5. Submit a pull request

## 🙏 Acknowledgments

- [NixOS](https://nixos.org/) - The Linux distribution
- [Hyprland](https://hyprland.org/) - The window manager
- [Nord Theme](https://www.nordtheme.com/) - The color scheme
- [Stylix](https://github.com/danth/stylix) - The theming system
