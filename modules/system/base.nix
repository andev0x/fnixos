{ pkgs, ... }: {
  # Essential system packages - minimal and fast
  environment.systemPackages = with pkgs; [
    git wget curl htop
    unzip zip
    brightnessctl  # For brightness control
    wofi           # Application launcher
    ranger         # Terminal file manager (lighter than dolphin)
  ];

  # Shell configuration
  programs.zsh.enable = true;

  # Security - wheel group sudo without password (for development)
  security.sudo.wheelNeedsPassword = false;

  # Networking
  networking.networkmanager.enable = true;
  
  # Audio support - optimized for performance
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Performance optimizations
    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };
  
  # Performance optimizations
  boot.kernelParams = [
    "mitigations=off"        # Disable CPU mitigations for better performance
    "preempt=full"           # Better preemption for desktop use
    "rcu_nocbs=0-3"          # Optimize RCU for ARM64
  ];
  
  # Memory management
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;    # Reduce swap usage
    "vm.vfs_cache_pressure" = 50;  # Optimize VFS cache
  };
  
  # Disable unnecessary services for performance
  services.blueman.enable = false;
  services.cups.enable = false;
  services.printing.enable = false;
  services.avahi.enable = false;
  services.udisks2.enable = false;
}
