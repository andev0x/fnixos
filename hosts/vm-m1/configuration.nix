{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/programs/devtools.nix
  ];

  # System identification
  networking.hostName = "fnixos";
  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  # Locales
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # User configuration
  users.users.andev = {
    isNormalUser = true;
    description = "andev0x";
    extraGroups = [ "wheel" "networkmanager" "video" "input" "audio" "docker" ];
    shell = pkgs.zsh;
    initialPassword = "hello";
  };

  # Home Manager integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.andev = import ../../home/default.nix;
  };

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # XWayland support
  programs.xwayland.enable = true;

  # Boot configuration - optimized
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  # Nix configuration
  nix.settings = {
    auto-optimise-store = true;
    warn-dirty = false;
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # System optimization
  systemd.services = {
    # Faster shutdown
    "user@".serviceConfig = {
      Delegate = "yes";
    };
  };

  # Disable some unnecessary services for VM
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  system.stateVersion = "25.05";
}
