{ pkgs, ... }: {
  # Package
  environment.systemPackages = with pkgs; [
    git wget curl htop
    vim neovim
    unzip zip
  ];

  # Shell
  programs.zsh.enable = true;

  # wheel sudo
  security.sudo.wheelNeedsPassword = false;

  # Networking
  networking.networkmanager.enable = true;
