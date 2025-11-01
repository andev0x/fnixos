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
  # Config files and assets
  # ─────────────────────────────
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.configFile."hypr/variables.conf".source = ./hypr/variables.conf;
  xdg.dataFile."wallpapers".source = ./wallpapers;
  xdg.dataFile."assets".source = ./assets;

  # ─────────────────────────────
  # Version tracking
  # ─────────────────────────────
  home.stateVersion = "25.05";
}
