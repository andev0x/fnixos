{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/029c8a77-2d09-418e-8c0f-935947c981ec";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3FAB-0605";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/5b668a70-19bb-4615-910b-df2b20c54101"; }
  ];
}
