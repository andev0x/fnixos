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

  # Time & Locale
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
