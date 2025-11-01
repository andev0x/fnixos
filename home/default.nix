{ pkgs, ... }: {
  home.username = "andev";
  home.homeDirectory = "/home/andev";

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "andev0x";
    userEmail = "andev@example.com";
  };

  # Cursor configuration
  home.pointerCursor = {
    name = "Adwaita";
    size = 16;
    package = pkgs.adwaita-icon-theme;
  };

  # Font configuration
  fonts.fontconfig.enable = true;

  # Terminal configuration
  programs.kitty.enable = false;
  programs.alacritty.enable = true;
  programs.tmux.enable = true;

  # Minimal packages
  home.packages = with pkgs; [
    fzf bat eza
    lazygit delta gitui
    ranger lf
    starship
    nerd-fonts
  ];

<<<<<<< HEAD
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
=======
  # Waybar configuration
  xdg.configFile."waybar/config".source = ./waybar/config;
>>>>>>> parent of ab6f306 (feat(home): update default.nix)
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/modules" = {
    recursive = true;
    source = ./waybar/modules;
  };
  xdg.configFile."waybar/includes" = {
    recursive = true;
    source = ./waybar/includes;
  };
  xdg.configFile."waybar/layouts" = {
    recursive = true;
    source = ./waybar/layouts;
  };
  xdg.configFile."waybar/menus" = {
    recursive = true;
    source = ./waybar/menus;
  };
  xdg.configFile."waybar/styles" = {
    recursive = true;
    source = ./waybar/styles;
  };
  xdg.configFile."waybar/theme.css".source = ./waybar/theme.css;
  xdg.configFile."waybar/user-style.css".source = ./waybar/user-style.css;

  # Hyprland configuration
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
<<<<<<< HEAD
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
  xdg.configFile."hypr/animations" = {
    recursive = true;
    source = ./hypr/animations;
  };
  xdg.configFile."hypr/shaders" = {
    recursive = true;
    source = ./hypr/shaders;
  };
  xdg.configFile."hypr/themes" = {
    recursive = true;
    source = ./hypr/themes;
  };
  xdg.configFile."hypr/workflows" = {
    recursive = true;
    source = ./hypr/workflows;
  };
  xdg.configFile."hypr/hyprlock" = {
    recursive = true;
    source = ./hypr/hyprlock;
  };

  # QT6 configuration
  xdg.configFile."qt6ct/qt6ct.conf".source = ./qt6ct/qt6ct.conf;
  xdg.configFile."qt6ct/colors.conf".source = ./qt6ct/colors.conf;

  # XSettingsd configuration
  xdg.configFile."xsettingsd/xsettingsd.conf".source = ./xsettingsd/xsettingsd.conf;

  # Fastfetch configuration
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;
  xdg.configFile."fastfetch/logo" = {
    recursive = true;
    source = ./fastfetch/logo;
  };

  # Data directories (wallpapers and assets)
  xdg.dataFile."wallpapers" = {
    recursive = true;
    source = ./wallpapers;
  };
  xdg.dataFile."assets" = {
    recursive = true;
    source = ./assets;
  };
=======

  # Wallpaper directory
  xdg.configFile."wallpapers".source = ./wallpapers;

  # assets (cursor, additional images)
  xdg.configFile."assets".source = ./assets;
>>>>>>> parent of ab6f306 (feat(home): update default.nix)

  home.stateVersion = "25.05";
}
