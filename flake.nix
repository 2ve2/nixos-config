{
  description = "lord2ve NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # AI coding tools, updated daily. It keeps its own nixpkgs so the
    # prebuilt packages from the Numtide cache match exactly.
    llm-agents.url = "github:numtide/llm-agents.nix";
    # ChatGPT account proxy for Pi. Its Nix flake exists only in 1.25 betas.
    codex-lb.url = "github:Soju06/codex-lb/v1.25.0-beta.9";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      llm-agents,
      codex-lb,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              aiPackages = llm-agents.packages.x86_64-linux;
              codexLbPackage = codex-lb.packages.x86_64-linux.default;
            };
            home-manager.users.lord2ve = import ./home.nix;
          }
        ];
      };
    };
}
