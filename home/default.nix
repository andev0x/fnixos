{ pkgs, ... }: {
  home.username = "andev";
  home.homeDirectory = "/home/andev";

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "anvndev";
    userEmail = "anvndev@gmail.com";
  };

  # Banana Cursor configuration
  home.pointerCursor = {
    name = "Banana";
    size = 24;
    package = pkgs.banana-cursor;
    gtk.enable = true;
    x11.enable = false;
  };
  
  # GTK configuration
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Banana";
      size = 24;
      package = pkgs.banana-cursor;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Qt configuration for Wayland
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # Terminal configuration
  programs.kitty.enable = false;
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
        padding = {
          x = 10;
          y = 10;
        };
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 11;
      };
      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      };
    };
  };

  programs.tmux.enable = true;

  # Essential packages
  home.packages = with pkgs; [
    fzf bat eza
    lazygit delta gitui
    ranger lf
    starship
    jq
    # Network tools
    networkmanagerapplet
    nm-tray
  ];

  # Waybar configuration
  xdg.configFile."waybar/config".source = ./waybar/config;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/style-dark.css".source = ./waybar/style-dark.css;
  xdg.configFile."waybar/style-light.css".source = ./waybar/style-light.css;

  # Wofi configuration
  xdg.configFile."wofi/config".source = ./wofi/config;
  xdg.configFile."wofi/style.css".source = ./wofi/style.css;
  xdg.configFile."wofi/style-dark.css".source = ./wofi/style-dark.css;
  xdg.configFile."wofi/style-light.css".source = ./wofi/style-light.css;

  # Hyprland configuration
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  # Scripts
  xdg.configFile."scripts/random-wall.sh" = { 
    source = ./scripts/random-wall.sh; 
    executable = true; 
  };
  xdg.configFile."scripts/toggle-theme.sh" = { 
    source = ./scripts/toggle-theme.sh; 
    executable = true; 
  };

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
        notification_limit = 5;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        indicate_hidden = "yes";
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        frame_color = "#5E81AC";
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        font = "JetBrainsMono Nerd Font 10";
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        icon_position = "left";
        word_wrap = "yes";
        icon_theme = "Papirus-Dark";
        sticky_history = "yes";
        history_length = 20;
      };
      urgency_low = {
        background = "#2E3440";
        foreground = "#ECEFF4";
        timeout = 5;
      };
      urgency_normal = {
        background = "#3B4252";
        foreground = "#ECEFF4";
        timeout = 8;
      };
      urgency_critical = {
        background = "#BF616A";
        foreground = "#ECEFF4";
        frame_color = "#D08770";
        timeout = 0;
      };
    };
  };

  # Wallpapers
  xdg.dataFile."wallpapers".source = ./wallpapers;

  home.stateVersion = "25.05";
}
