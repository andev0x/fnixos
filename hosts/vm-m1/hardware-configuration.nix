{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Optimized kernel modules for VMware Fusion on ARM64
  boot.initrd.availableKernelModules = [ 
    "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod"
    "vmw_pvscsi" "vmw_vmci" "vmwgfx" # VMware-specific modules
  ];
  boot.initrd.kernelModules = [ "vmw_balloon" ];
  boot.kernelModules = [ "vmwgfx" "vmw_balloon" "vmw_vmci" "vmw_vsock_vmci_transport" ];
  boot.extraModulePackages = [ ];

  # Filesystem configuration with optimizations
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/029c8a77-2d09-418e-8c0f-935947c981ec";
    fsType = "ext4";
    options = [ 
      "noatime" 
      "nodiratime" 
      "discard" 
      "commit=60" 
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3FAB-0605";
    fsType = "vfat";
    options = [ "defaults" "noatime" ];
  };

  # Swap configuration with optimization
  swapDevices = [
    { 
      device = "/dev/disk/by-uuid/5b668a70-19bb-4615-910b-df2b20c54101";
      priority = 100;
    }
  ];

  # Hardware optimization for ARM64
  hardware.enableRedistributableFirmware = true;
  
  # CPU frequency scaling for ARM64
  powerManagement.cpuFreqGovernor = "ondemand";
  
  # Enable zram for better memory management
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
}
