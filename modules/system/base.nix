{ pkgs, ... }: {
  # Essential system packages
  environment.systemPackages = with pkgs; [
    git wget curl htop
    unzip zip
    brightnessctl  # For brightness control
    wofi           # Application launcher
    dolphin        # File manager
  ];

  # Shell configuration
  programs.zsh.enable = true;

  # Security - wheel group sudo without password (for development)
  security.sudo.wheelNeedsPassword = false;

  # Networking
  networking.networkmanager.enable = true;
  
  # Audio support
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
