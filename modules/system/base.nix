{ pkgs, ... }: {
  # Essential system packages - minimal
  environment.systemPackages = with pkgs; [
    git wget curl htop
    unzip zip
    brightnessctl  # For brightness control
    wofi           # Application launcher
    ranger         # Terminal file manager
  ];

  # Shell configuration
  programs.zsh.enable = true;

  # Security - wheel group sudo without password (for development)
  security.sudo.wheelNeedsPassword = false;

  # Networking
  networking.networkmanager.enable = true;

  # Audio support - minimal setup
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Performance optimizations
  boot.kernelParams = [
    "mitigations=off"        # Disable CPU mitigations for better performance
    "preempt=full"           # Better preemption for desktop use
  ];

  # Memory management
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;    # Reduce swap usage
  };

  # Disable unnecessary services for performance
  services.blueman.enable = false;
  services.printing.enable = false;
  services.avahi.enable = false;
  services.udisks2.enable = false;
}
