{
  description = "fnixos - NixOS Flake for VMware Fusion ARM (M1) with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.targets.gnome.enable = false;
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
    let
      system = "aarch64-linux";
    in {
      nixosConfigurations = {
        vm-m1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/vm-m1/configuration.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              nixpkgs.config.allowUnfree = true;
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
            }
          ];
        };
      };
    };
}
