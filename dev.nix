{ pkgs, ... }:

{
  # Languages and tools available everywhere
  home.packages = with pkgs; [
    nodejs
    bun
    pnpm
    python3
    lazydocker
    nixd
    nixfmt
  ];

  # VS Code with extensions installed from Nix
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      biomejs.biome
      esbenp.prettier-vscode
      dbaeumer.vscode-eslint
      bradlc.vscode-tailwindcss
      yoavbls.pretty-ts-errors
      usernamehw.errorlens
      eamodio.gitlens
      ms-python.python
    ];
  };
}
