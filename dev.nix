{ pkgs, ... }:

{
  # Languages and tools available everywhere
  home.packages = with pkgs; [
    nodejs
    bun
    pnpm
    yarn-berry
    python3
    lazydocker
    nixd
    nixfmt
    biome
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
