{ pkgs, ... }: {
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    wl-clipboard
    grim slurp       # screenshot
    brightnessctl
    pavucontrol
    swww             # wallpaper manager
  ];

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  stylix.enable = true;
  stylix.base16Scheme = "nord";
  stylix.cursor.enable = true;
  stylix.fonts.sansSerif = "JetBrainsMono Nerd Font";
}
