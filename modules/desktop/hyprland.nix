{ pkgs, ... }: {
  # Hyprland window manager - pure Wayland setup
  programs.hyprland.enable = true;

  # Minimal display manager - no desktop environment needed
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "sugar-candy";

  # Font configuration - manual setup to avoid GNOME dependencies
  fonts.packages = with pkgs; [
    nerdfonts.override { fonts = [ "JetBrainsMono" ]; }
    noto-fonts-emoji
  ];

  # Cursor theme
  services.xserver.displayManager.sessionCommands = ''
    xsetroot -cursor_name left_ptr
  '';

  # Font configuration
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" ];
    sansSerif = [ "JetBrainsMono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };

  # Essential Wayland packages - minimal and performance-focused
  environment.systemPackages = with pkgs; [
    # Core Wayland
    waybar          # Lightweight status bar
    swww            # Fast wallpaper daemon
    grim            # Screenshot tool
    slurp           # Region selector
    wl-clipboard    # Clipboard utilities

    # Authentication (lightweight alternative to polkit-gnome)
    polkit-kde-agent

    # Essential utilities
    wofi            # Application launcher
    wlogout         # Logout menu
    hyprpaper       # Alternative wallpaper daemon (faster than swww)
  ];

  # Security policy kit
  security.polkit.enable = true;

  # Disable unnecessary services for performance
  # services.xserver.desktopManager.gnome.enable = false;
  # services.xserver.desktopManager.plasma5.enable = false;
  # services.xserver.desktopManager.xfce.enable = false;
}
