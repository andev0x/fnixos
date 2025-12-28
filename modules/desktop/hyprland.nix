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

    # Cursor theme
    (pkgs.stdenv.mkDerivation {
      name = "banana-cursor";
      src = pkgs.fetchFromGitHub {
        owner = "ful1e5";
        repo = "banana-cursor";
        rev = "v2.0.0";
        sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };
      installPhase = ''
        mkdir -p $out/share/icons
        cp -r themes/* $out/share/icons/
      '';
    })

    # Authentication
    kdePackages.polkit-kde-agent-1

    # Essential utilities
    wofi            # Application launcher
    wlogout         # Logout menu
    mesa
    mesa.drivers
    vulkan-tools
    glxinfo
  ];

  # Security policy kit
  security.polkit.enable = true;

  # Desktop portals for Wayland apps
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
