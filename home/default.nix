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
    package = pkgs.gnome.adwaita-icon-theme;
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

  # Waybar configuration
  xdg.configFile."waybar/config".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

  # Hyprland configuration
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  # Wallpaper directory
  xdg.configFile."wallpapers".source = ./wallpapers;

  # assets (cursor, additional images)
  xdg.configFile."assets".source = ./assets;

  home.stateVersion = "25.05";
}
