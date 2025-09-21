{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    go
    rustup
    neovim 
    ripgrep fd tree-sitter
  ];

  environment.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
