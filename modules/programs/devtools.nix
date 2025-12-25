{ pkgs, ... }: {
  # Development tools - essential and optimized
  environment.systemPackages = with pkgs; [
    # Build tools
    gcc
    gnumake
    cmake
    pkg-config

    # Programming languages
    go
    rustup
    python3
    nodejs

    # Text editors
    neovim

    # Development utilities
    ripgrep
    fd
    git-lfs

    # Web browser
    qutebrowser

    # Terminal emulators
    alacritty
    kitty
    tmux

    # File management
    ranger
    fzf
    bat
    eza
    
    # System monitoring
    fastfetch
    iotop
    sysstat
  ];

  # Shell aliases
  environment.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    ll = "eza -la --icons";
    la = "eza -A --icons";
    l = "eza --icons";
    ls = "eza --icons";
    grep = "rg";
    find = "fd";
    cat = "bat";
    
    # NixOS shortcuts
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#vm-m1";
    update = "sudo nix flake update /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos#vm-m1";
    clean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
    generations = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
}
