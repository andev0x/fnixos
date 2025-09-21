# fnixos - NixOS Configuration for ARM64 M1 MacBook

A minimal, scientific, and beautiful NixOS configuration optimized for VMware Fusion on ARM64 M1 MacBooks with Hyprland window manager.

## 🚀 Features

- **ARM64 Optimized**: Specifically configured for Apple M1 MacBooks
- **Hyprland Desktop**: Modern Wayland compositor with beautiful animations
- **Nord Theme**: Consistent Nord color scheme throughout
- **Minimal & Scientific**: Clean, logical configuration structure
- **Developer Ready**: Pre-configured development tools and utilities
- **Custom Wallpapers**: Easy wallpaper management system

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

2. **Build the system:**
   ```bash
   sudo nixos-rebuild switch --flake .#vm-m1
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

## 🔧 Development Tools

Pre-installed development tools:
- **Editors**: Neovim (default), Vim
- **Languages**: Go, Rust, Python, Node.js
- **Build Tools**: GCC, CMake, Make
- **Utilities**: Git, ripgrep, fd, bat, exa
- **Shell**: Zsh with useful aliases

## 📋 System Requirements

- **Architecture**: ARM64 (aarch64-linux)
- **Platform**: VMware Fusion on Apple M1 MacBook
- **Memory**: Minimum 4GB RAM
- **Storage**: Minimum 20GB free space

## 🔄 Updates

To update your system:
```bash
cd fnixos
git pull
sudo nixos-rebuild switch --flake .#vm-m1 --upgrade
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
