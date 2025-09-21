{ pkgs, ... }: {
  # Development tools and compilers - optimized for coding
  environment.systemPackages = with pkgs; [
    # Compilers and build tools
    gcc
    gnumake
    cmake
    pkg-config
    ninja          # Faster build system
    
    # Programming languages
    go
    rustup
    python3
    nodejs
    deno           # Modern JavaScript/TypeScript runtime
    
    # Text editors and IDEs
    neovim
    vscode         # VS Code for web development
    helix          # Modern modal editor
    
    # Development utilities
    ripgrep        # Fast text search
    fd             # Better find
    tree-sitter    # Syntax highlighting
    git-lfs        # Git large file storage
    lazygit        # Terminal Git UI
    delta          # Better git diff
    gitui          # Terminal Git UI
    
    # Web development
    firefox        # Primary browser
    chromium       # Secondary browser for testing
    brave          # Privacy-focused browser
    curl           # HTTP client
    wget           # Download tool
    
    # Terminal and shell
    tmux           # Terminal multiplexer
    zsh            # Shell
    starship       # Fast shell prompt
    
    # File management
    ranger         # Terminal file manager
    lf             # Lightweight file manager
    fzf            # Fuzzy finder
    bat            # Better cat
    exa            # Better ls
    tree            # Directory tree
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
    cd = "z";
    top = "htop";
    ps = "procs";
    du = "dust";
    df = "duf";
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
  };

  
