{ pkgs, ... }: {
  # Development tools and compilers
  environment.systemPackages = with pkgs; [
    # Compilers and build tools
    gcc
    gnumake
    cmake
    pkg-config
    
    # Programming languages
    go
    rustup
    
    # Text editors
    neovim
    
    # Development utilities
    ripgrep    # Fast text search
    fd         # Better find
    tree-sitter # Syntax highlighting
    git-lfs    # Git large file storage
    nodejs     # Node.js runtime
    python3    # Python interpreter
  ];

  # Shell aliases for better developer experience
  environment.shellAliases = {
    vi = "nvim";
    vim = "nvim";
    ll = "ls -la";
    la = "ls -A";
    l = "ls -CF";
    grep = "rg";
    find = "fd";
    cat = "bat";
  };

  # Enable development features
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
