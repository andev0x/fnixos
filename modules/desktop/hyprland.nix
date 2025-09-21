{ pkgs, ... }: {
  # Hyprland window manager - pure Wayland setup
  programs.hyprland.enable = true;

  # Stylix theming - minimal configuration
  stylix = {
    enable = true;
    image = ./wallpapers/nord-landscape.jpg;
    theme = "nord";
    fonts = {
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
    };
    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 20;
    };
  };

  # Minimal display manager - no desktop environment needed
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Additional font packages
  fonts.packages = with pkgs; [
    noto-fonts-emoji
  ];

  # Essential Wayland packages - minimal and performance-focused
  environment.systemPackages = with pkgs; [
    # Core Wayland
    hyprland        # Window manager
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
