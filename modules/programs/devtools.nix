{ pkgs, ... }: {
  # Development tools - minimal and essential
  environment.systemPackages = with pkgs; [
    # Compilers and build tools
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
    ripgrep        # Fast text search
    fd             # Better find
    git-lfs        # Git large file storage
    
    # Web browsers
    firefox        # Primary browser
    chromium       # Secondary browser
    
    # Terminal and shell
    tmux           # Terminal multiplexer
    zsh            # Shell
    starship       # Fast shell prompt
    
    # File management
    ranger         # Terminal file manager
    fzf            # Fuzzy finder
    bat            # Better cat
    exa            # Better ls
  ];

  # Shell aliases for better developer experience
  environment.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    ll = "exa -la";
    la = "exa -A";
    l = "exa";
    ls = "exa";
    grep = "rg";
    find = "fd";
    cat = "bat";
  };

  # Enable development features
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  # Enable Zsh with basic configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    # Initialize Starship prompt
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  # Enable Starship prompt
  programs.starship = {
    enable = true;
  };
}