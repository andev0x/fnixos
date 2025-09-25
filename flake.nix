{
  description = "fnixos - NixOS Flake for VMware Fusion ARM (M1) with Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      nixosConfigurations = {
        vm-m1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/vm-m1/configuration.nix
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.allowUnfree = true;
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
            }
          ];
        };
      };

      # Developer shells for local development workflows
      devShells.${system} = {
        # General-purpose shell (kept minimal)
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.git
            pkgs.ripgrep
            pkgs.fd
          ];
        };

        # Go-focused shell with common tools and linters
        go = pkgs.mkShell {
          buildInputs = [
            pkgs.go
            pkgs.gopls
            pkgs.golangci-lint
            pkgs.gotools
            pkgs.gotests
            pkgs.gomodifytags
            pkgs.impl
            pkgs.iferr
          ];

          shellHook = ''
            echo "[devshell] Go toolchain active"
            go version || true
          '';
        };
      };
    };
}
