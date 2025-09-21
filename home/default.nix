{ pkgs, ... }: {
  home.username = "andev";
  home.homeDirectory = "/home/andev";

  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    userName = "AnDev0x";
    userEmail = "you@example.com";
  };

  programs.kitty.enable = true;
  programs.alacritty.enable = true;
  programs.tmux.enable = true;

  home.packages = with pkgs; [
    fzf bat exa
  ];

  # Waybar config minimal + Nord theme
  xdg.configFile."waybar/config".text = ''
  {
    "layer": "top",
    "position": "top",
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["pulseaudio", "network", "battery"],
    "clock": { "format": "{:%H:%M %d-%m-%Y}" },
    "pulseaudio": { "format": " {volume}%" },
    "network": { "format-wifi": " {essid}", "format-ethernet": " {ifname}" },
    "battery": { "format": "{capacity}% " }
  }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: JetBrainsMono Nerd Font;
      font-size: 13px;
      color: #ECEFF4;
    }
    window#waybar {
      background-color: #2E3440;
      border-bottom: 2px solid #4C566A;
    }
  '';

  # Wallpaper startup
  xdg.configFile."hypr/startup.conf".text = ''
    exec-once = swww init && swww img ~/Pictures/wallpapers/nord.jpg
  '';

  home.stateVersion = "25.05";
}
