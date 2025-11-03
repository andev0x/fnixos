{ pkgs, ... }: {
  home.username = "andev";
  home.homeDirectory = "/home/andev";

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "anvndev";
    userEmail = "anvndev@gmail.com";
  };

  # Cursor configuration - Banana Cursor (if available, fallback to Adwaita)
  home.pointerCursor = {
    name = "Banana";
    size = 24;
    package = pkgs.papirus-icon-theme;
  };
  
  # GTK configuration
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Banana";
      package = pkgs.papirus-icon-theme;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

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
    rofi-wayland      # For app switching
    swww              # Wallpaper daemon
    dunst             # Notification daemon
    pavucontrol       # Audio control
    brightnessctl     # Brightness control
    jq                # JSON parsing for Waybar custom module
  ];

  # Waybar configuration
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/style-dark.css".source = ./waybar/style-dark.css;
  xdg.configFile."waybar/style-light.css".source = ./waybar/style-light.css;

  # Wofi configuration - Enhanced app menu
  xdg.configFile."wofi/config".source = ./wofi/config;
  xdg.configFile."wofi/style.css".source = ./wofi/style.css;
  xdg.configFile."wofi/style-dark.css".source = ./wofi/style-dark.css;
  xdg.configFile."wofi/style-light.css".source = ./wofi/style-light.css;

  # Hyprland configuration
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  # Scripts
  xdg.configFile."scripts/random-wall.sh" = { source = ./scripts/random-wall.sh; executable = true; };
  xdg.configFile."scripts/active-app.sh" = { source = ./scripts/active-app.sh; executable = true; };
  xdg.configFile."scripts/toggle-theme.sh" = { source = ./scripts/toggle-theme.sh; executable = true; };

  # Dunst notification daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "keyboard";
        width = 350;
        height = 300;
        origin = "top-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 10;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        frame_color = "#5E81AC";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrainsMono Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_theme = "Papirus";
        sticky_history = "yes";
        history_length = 20;
      };
      urgency_low = {
        background = "#2E3440";
        foreground = "#ECEFF4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#3B4252";
        foreground = "#ECEFF4";
        timeout = 10;
      };
      urgency_critical = {
        background = "#BF616A";
        foreground = "#ECEFF4";
        frame_color = "#D08770";
        timeout = 0;
      };
    };
  };

  # Wallpaper directory - use dataFile for wallpapers
  xdg.dataFile."wallpapers".source = ./wallpapers;

  home.stateVersion = "25.05";
}
