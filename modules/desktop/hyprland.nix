{ pkgs, ... }: {
  # Hyprland window manager
  programs.hyprland.enable = true;
  
  # Display manager - SDDM for better Wayland support
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Stylix theming system
  stylix = {
    enable = true;
    autoEnable = true;

    fonts = {
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

    theme = {
      gtk = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      icons = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };
  };

  # Desktop environment packages
  environment.systemPackages = with pkgs; [
    waybar          # Status bar
    swww            # Wallpaper daemon
    grim            # Screenshot tool
    slurp           # Region selector
    wl-clipboard    # Clipboard utilities
    polkit_gnome    # Authentication agent
  ];

  # Security policy kit
  security.polkit.enable = true;
}
