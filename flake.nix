{
  description = "fnixos - Optimized NixOS Flake for VMware Fusion ARM64 (Apple Silicon) with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # ARM64-specific optimizations
          # replaceStdenv = { pkgs }: pkgs.ccacheStdenv;
        };
      };
    in {
      nixosConfigurations = {
        vm-m1 = nixpkgs.lib.nixosSystem {
          inherit system;
        # specialArgs = { inherit pkgs; };
          modules = [
            ./hosts/vm-m1/configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;

              # Nix settings optimized for ARM64
              nix.settings = {
                experimental-features = [ "nix-command" "flakes" ];
                auto-optimise-store = true;
                max-jobs = "auto";
                cores = 0; # Use all available cores
                sandbox = true;
                substituters = [
                  "https://cache.nixos.org"
                  "https://nix-community.cachix.org"
                ];
                trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                ];
                # Performance optimization for ARM64
                build-cores = 0;
                max-silent-time = 3600;
              };
            }
          ];
        };
      };
    };
}
