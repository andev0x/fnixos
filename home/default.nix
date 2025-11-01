{ pkgs, ... }:

{
  home.username = "andev";
  home.homeDirectory = "/home/andev";

  # ─────────────────────────────
  # Shell and Git
  # ─────────────────────────────
  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "andev0x";
    userEmail = "andev@example.com";
  };

  # ─────────────────────────────
  # Cursor configuration
  # ─────────────────────────────
  home.pointerCursor = {
    name = "Adwaita";
    size = 16;
    package = pkgs.adwaita-icon-theme;
  };

  # ─────────────────────────────
  # Fonts
  # ─────────────────────────────
  fonts.fontconfig.enable = true;

  # ─────────────────────────────
  # Terminal programs
  # ─────────────────────────────
  programs.kitty.enable = false;
  programs.alacritty.enable = true;
  programs.tmux.enable = true;

  # ─────────────────────────────
  # User packages
  # ─────────────────────────────
  home.packages = with pkgs; [
    # CLI utilities
    fzf bat eza
    lazygit delta gitui
    ranger lf
    starship

    # Fonts (fixed)
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  # ─────────────────────────────
  # Starship configuration
  # ─────────────────────────────
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship/starship.toml);
  };

  # ─────────────────────────────
  # Config files and assets
  # ─────────────────────────────
  
  # Waybar configuration
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/modules".source = ./waybar/modules;
  xdg.configFile."waybar/includes".source = ./waybar/includes;
  xdg.configFile."waybar/layouts".source = ./waybar/layouts;
  xdg.configFile."waybar/menus".source = ./waybar/menus;
  xdg.configFile."waybar/styles".source = ./waybar/styles;
  xdg.configFile."waybar/theme.css".source = ./waybar/theme.css;
  xdg.configFile."waybar/user-style.css".source = ./waybar/user-style.css;

  # Hyprland configuration
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.configFile."hypr/variables.conf".source = ./hypr/variables.conf;
  xdg.configFile."hypr/keybindings.conf".source = ./hypr/keybindings.conf;
  xdg.configFile."hypr/windowrules.conf".source = ./hypr/windowrules.conf;
  xdg.configFile."hypr/monitors.conf".source = ./hypr/monitors.conf;
  xdg.configFile."hypr/userprefs.conf".source = ./hypr/userprefs.conf;
  xdg.configFile."hypr/animations.conf".source = ./hypr/animations.conf;
  xdg.configFile."hypr/workflows.conf".source = ./hypr/workflows.conf;
  xdg.configFile."hypr/shaders.conf".source = ./hypr/shaders.conf;
  xdg.configFile."hypr/hypridle.conf".source = ./hypr/hypridle.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./hypr/hyprlock.conf;
  xdg.configFile."hypr/nvidia.conf".source = ./hypr/nvidia.conf;
  xdg.configFile."hypr/pyprland.toml".source = ./hypr/pyprland.toml;
  xdg.configFile."hypr/animations".source = ./hypr/animations;
  xdg.configFile."hypr/shaders".source = ./hypr/shaders;
  xdg.configFile."hypr/themes".source = ./hypr/themes;
  xdg.configFile."hypr/workflows".source = ./hypr/workflows;
  xdg.configFile."hypr/hyprlock".source = ./hypr/hyprlock;

  # QT6 configuration
  xdg.configFile."qt6ct/qt6ct.conf".source = ./qt6ct/qt6ct.conf;
  xdg.configFile."qt6ct/colors.conf".source = ./qt6ct/colors.conf;

  # XSettingsd configuration
  xdg.configFile."xsettingsd/xsettingsd.conf".source = ./xsettingsd/xsettingsd.conf;

  # Fastfetch configuration
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
  xdg.configFile."fastfetch/logo".source = ./fastfetch/logo;

  # Data directories (wallpapers and assets)
  xdg.dataFile."wallpapers".source = ./wallpapers;
  xdg.dataFile."assets".source = ./assets;

  # ─────────────────────────────
  # Version tracking
  # ─────────────────────────────
  home.stateVersion = "25.05";
}
