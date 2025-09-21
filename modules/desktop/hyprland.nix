{ pkgs, ... }: {
  # Hyprland window manager - pure Wayland setup
  programs.hyprland.enable = true;

  # Minimal display manager - no desktop environment needed
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "sugar-candy";

  # Stylix theming system - minimal and fast
  stylix = {
    enable = true;
    autoEnable = true;

    fonts = {
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 20;  # Smaller cursor for better performance
    };

    theme = {
      gtk = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      icons = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };
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
