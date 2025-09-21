{ pkgs, ... }: {
  services.xserver.enable = true;

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    wget curl htop fastfetch
    kitty alacritty
    firefox
  ];

  networking.networkmanager.enable = true;
}
