{ pkgs, ... }: {
  programs.hyprland.enable = true;
  services.xserver.displayManager.gdm.enable = true;

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

  environment.systemPackages = with pkgs; [
    waybar swww grim slurp wl-clipboard
  ];
}
