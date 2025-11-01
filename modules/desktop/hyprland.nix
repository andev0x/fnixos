{ pkgs, ... }: {
  # Hyprland window manager - pure Wayland setup
  programs.hyprland.enable = true;

  # Minimal display manager (SDDM Wayland)
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Font configuration - minimal setup
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font" ];
    sansSerif = [ "JetBrainsMono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };

  # Essential Wayland packages - minimal set
  environment.systemPackages = with pkgs; [
    # Core Wayland
    hyprland        # Window manager
    waybar          # Status bar
    swww            # Wallpaper daemon
    grim            # Screenshot tool
    slurp           # Region selector
    wl-clipboard    # Clipboard utilities
    hyprlock        # Screen locker
    hypridle        # Idle daemon
    hyprpicker      # Color picker
    cliphist        # Clipboard manager

    # Authentication
    kdePackages.polkit-kde-agent-1

    # Essential utilities
    wofi            # Application launcher
    wlogout         # Logout menu
    playerctl       # Media control
    mesa
    mesa.drivers
    vulkan-tools
    glxinfo
    jq              # JSON parser for scripts
  ];

  # Security policy kit
  security.polkit.enable = true;

  # Desktop portals for Wayland apps
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Hyprland services
  services.hypridle.enable = true;
  
  # Waybar service (optional - can also be started from hyprland.conf)
  # Uncomment if you want waybar to run as a systemd service
  # systemd.user.services.waybar = {
  #   enable = true;
  #   wantedBy = [ "hyprland-session.target" ];
  # };
}
