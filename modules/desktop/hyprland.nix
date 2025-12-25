{ pkgs, ... }: {
  # Hyprland window manager - Wayland compositor optimized for ARM64
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # SDDM display manager with Wayland
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General = {
        InputMethod = "";
      };
    };
  };

  # Optimized font configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
      emoji = [ "Noto Color Emoji" ];
    };
    # Font rendering optimization
    subpixel.rgba = "rgb";
    hinting = {
      enable = true;
      style = "slight";
    };
    antialias = true;
  };

  # Wayland essentials - optimized package selection
  environment.systemPackages = with pkgs; [
    # Core Wayland
    hyprland
    waybar
    swww
    grim
    slurp
    wl-clipboard
    swappy
    dunst
    rofi-wayland

    # Authentication
    kdePackages.polkit-kde-agent-1

    # Utilities
    wofi
    wlogout
    pavucontrol
    brightnessctl
    
    # Graphics acceleration for ARM64
    mesa
    mesa.drivers
    vulkan-tools
    glxinfo
    wayland-utils
    
    # Cursor theme
    banana-cursor
  ];

  # Security
  security.polkit.enable = true;

  # XDG Desktop Portal for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "wlr" "gtk" ];
      };
      hyprland = {
        default = [ "wlr" "gtk" ];
      };
    };
  };

  # OpenGL/Vulkan support for ARM64
  hardware.graphics = {
    enable = true;
    enable32Bit = false; # Disable for ARM64
  };

  # Environment variables for Wayland/Hyprland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1"; # Fix for VMware
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_THEME = "Banana";
    XCURSOR_SIZE = "24";
  };
}
