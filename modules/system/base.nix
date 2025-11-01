{ pkgs, ... }: {
  # Shell configuration - handled by modules/programs/devtools.nix
  # programs.zsh.enable = true;  # Moved to devtools.nix

  # Essential system packages
  environment.systemPackages = with pkgs; [
    git wget curl htop
    unzip zip
    brightnessctl  # Brightness control
    wofi           # App launcher
    ranger         # Terminal file manager
  ];

  # Networking
  networking.networkmanager.enable = true;

  # Audio (note: hardware.pulseaudio → services.pulseaudio in newer NixOS)
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Virtualization guest tools - configured in hosts/vm-m1/configuration.nix
  # services.vmwareGuest.enable = true;  # Moved to hosts/vm-m1/configuration.nix

  # Security - allow wheel group sudo without password
  security.sudo.wheelNeedsPassword = false;

  # Performance optimizations
  boot.kernelParams = [
    "mitigations=off"  # Disable CPU mitigations for better performance
    "preempt=full"     # Better desktop responsiveness
  ];

  # Memory management
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  # Swap configuration - handled by hardware-configuration.nix
  # Uncomment if you need a swapfile instead of a swap device:
  # swapDevices = [
  #   { device = "/swapfile"; size = 2048; } # 2GB swap file
  # ];

  # Disable unnecessary services
  services.printing.enable = false;  # cups → printing
  services.avahi.enable = false;
  services.udisks2.enable = false;
  services.blueman.enable = false;
}
