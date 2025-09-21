{ pkgs, ... }: {
  # Hyprland
  programs.hyprland.enable = true;

  # Display manager (chạy Wayland)
  services.xserver.displayManager.gdm.enable = true;

  # Stylix theme setup
  stylix = {
    enable = true;

    fonts = {
      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
      };
    };

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

    gtk = {
      theme = {
        package = pkgs.nordic;
        name = "Nordic";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus";
      };
    };
  };

  # Waybar + swww (wallpaper)
  environment.systemPackages = with pkgs; [
    waybar swww grim slurp wl-clipboard
  ];
}
