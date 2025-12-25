{ pkgs, ... }: {
  # Shell
  programs.zsh.enable = true;

  # Essential system packages
  environment.systemPackages = with pkgs; [
    git wget curl htop
    unzip zip
    brightnessctl
    wofi
    ranger
    pciutils
    usbutils
  ];

  # Networking
  networking.networkmanager.enable = true;

  # Audio with PipeWire (optimized for low latency)
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # Low latency configuration
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
      };
    };
  };

  # VMware Fusion guest tools
  virtualisation.vmware.guest = {
    enable = true;
    headless = false;
  };

  # Security
  security.sudo.wheelNeedsPassword = false;

  # ARM64 and VMware optimized kernel parameters
  boot.kernelParams = [
    "mitigations=off"
    "preempt=full"
    "transparent_hugepage=madvise"
    "split_lock_detect=off"
    # VMware-specific optimizations
    "vmwgfx.enable_fbdev=1"
    "intel_iommu=off"
  ];

  # Optimized kernel settings for ARM64
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_background_ratio" = 5;
    "vm.dirty_ratio" = 10;
    "kernel.nmi_watchdog" = 0;
    "kernel.sched_migration_cost_ns" = 5000000;
    "kernel.sched_autogroup_enabled" = 1;
  };

  # Remove duplicate swap configuration (handled in hardware-configuration.nix)
  swapDevices = [ ];

  # Disable unnecessary services for VM
  services.printing.enable = false;
  services.avahi.enable = false;
  services.udisks2.enable = false;
  services.blueman.enable = false;
  
  # Optimize for ARM64 performance
  powerManagement = {
    enable = true;
    powertop.enable = false; # Disable for VM
  };

  # Faster boot
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
